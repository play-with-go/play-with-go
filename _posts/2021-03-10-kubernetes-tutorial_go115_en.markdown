---
category: Next steps
difficulty: Beginner
excerpt: Ready to take the plunge and install Go on your system?!
guide: 2021-03-10-kubernetes-tutorial
lang: en
layout: post
title: Kubernetes Tutorial
---

In this tutorial we show how to convert Kubernetes configuration files
for a collection of microservices.

The configuration files are scrubbed and renamed versions of
real-life configuration files.
The files are organized in a directory hierarchy grouping related services
in subdirectories.
This is a common pattern.
The `cue` tooling has been optimized for this use case.

In this tutorial we will address the following topics:

1. convert the given YAML files to CUE
1. hoist common patterns to parent directories
1. use the tooling to rewrite CUE files to drop unnecessary fields
1. repeat from step 2 for different subdirectories
1. define commands to operate on the configuration
1. extract CUE templates directly from Kubernetes Go source
1. manually tailor the configuration
1. map a Kubernetes configuration to `docker-compose` (TODO)

<pre data-command-src="Y3VlIHZlcnNpb24K"><code class="language-.term1">$ cue version
cue version (devel) linux/amd64
</code></pre>

<pre data-command-src="Z2l0IGNsb25lIC1xIGh0dHBzOi8vY3VlLmdvb2dsZXNvdXJjZS5jb20vY3VlCmNkIGN1ZQpnaXQgY2hlY2tvdXQgLXEgZjAxNGMxNGM5N2IxM2E0MGYwYzg1ZTE4ODQzZjcxYTZjZTBjMWQyMgpjZCAvaG9tZS9nb3BoZXIvY3VlL2RvYy90dXRvcmlhbC9rdWJlcm5ldGVzCg=="><code class="language-.term1">$ git clone -q https://cue.googlesource.com/cue
$ cd cue
$ git checkout -q f014c14c97b13a40f0c85e18843f71a6ce0c1d22
$ cd /home/gopher/cue/doc/tutorial/kubernetes
</code></pre>

## The given data set

The data set is based on a real-life case, using different names for the
services.
All the inconsistencies of the real setup are replicated in the files
to get a realistic impression of how a conversion to CUE would behave
in practice.

The given YAML files are ordered in following directory
(you can use `find` if you don't have tree):


<pre data-command-src="dHJlZSAuL29yaWdpbmFsIHwgaGVhZAo="><code class="language-.term1">$ tree ./original | head
./original
`-- services
    |-- frontend
    |   |-- bartender
    |   |   `-- kube.yaml
    |   |-- breaddispatcher
    |   |   `-- kube.yaml
    |   |-- host
    |   |   `-- kube.yaml
    |   |-- maitred
</code></pre>

Each subdirectory contains related microservices that often share similar
characteristics and configurations.
The configurations include a large variety of Kubernetes objects, including
services, deployments, config maps,
a daemon set, a stateful set, and a cron job.

The result of the first tutorial is in the `quick`, for "quick and dirty"
directory.
A manually optimized configuration can be found int `manual`
directory.


## Importing existing configuration

We first make a copy of the data directory.

<pre data-command-src="Y3AgLWEgb3JpZ2luYWwgdG1wCmNkIHRtcAo="><code class="language-.term1">$ cp -a original tmp
$ cd tmp
</code></pre>

We initialize a module so that we can treat all our configuration files
in the subdirectories as part of one package.
We do that later by giving all the same package name.

<pre data-command-src="Y3VlIG1vZCBpbml0Cg=="><code class="language-.term1">$ cue mod init
</code></pre>

Creating a module also allows our packages import external packages.

Let's try to use the `cue import` command to convert the given YAML files
into CUE.

<pre data-command-src="Y2Qgc2VydmljZXMKY3VlIGltcG9ydCAuLy4uLgo="><code class="language-.term1">$ cd services
$ cue import ./...
path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml
</code></pre>

Since we have multiple packages and files, we need to specify the package to
which they should belong.

<pre data-command-src="Y3VlIGltcG9ydCAuLy4uLiAtcCBrdWJlCg=="><code class="language-.term1">$ cue import ./... -p kube
path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml
</code></pre>

Many of the files contain more than one Kubernetes object.
Moreover, we are creating a single configuration that contains all objects
of all files.
We need to organize all Kubernetes objects such that each is individually
identifiable within a single configuration.
We do so by defining a different struct for each type putting each object
in this respective struct keyed by its name.
This allows objects of different types to share the same name,
just as is allowed by Kubernetes.
To accomplish this, we tell `cue` to put each object in the configuration
tree at the path with the "kind" as first element and "name" as second.

<pre data-command-src="Y3VlIGltcG9ydCAuLy4uLiAtcCBrdWJlIC1sICdzdHJpbmdzLlRvQ2FtZWwoa2luZCknIC1sIG1ldGFkYXRhLm5hbWUgLWYK"><code class="language-.term1">$ cue import ./... -p kube -l &#39;strings.ToCamel(kind)&#39; -l metadata.name -f
</code></pre>

The added `-l` flag defines the labels for each object, based on values from
each object, using the usual CUE syntax for field labels.
In this case, we use a camelcase variant of the `kind` field of each object and
use the `name` field of the `metadata` section as the name for each object.
We also added the `-f` flag to overwrite the few files that succeeded before.

Let's see what happened:

<pre data-command-src="dHJlZSAuIHwgaGVhZAo="><code class="language-.term1">$ tree . | head
.
|-- frontend
|   |-- bartender
|   |   |-- kube.cue
|   |   `-- kube.yaml
|   |-- breaddispatcher
|   |   |-- kube.cue
|   |   `-- kube.yaml
|   |-- host
|   |   |-- kube.cue
</code></pre>

Each of the YAML files is converted to corresponding CUE files.
Comments of the YAML files are preserved.

The result is not fully pleasing, though.
Take a look at `mon/prometheus/configmap.cue`.

<pre data-command-src="Y2F0IG1vbi9wcm9tZXRoZXVzL2NvbmZpZ21hcC5jdWUgfCBoZWFkCg=="><code class="language-.term1">$ cat mon/prometheus/configmap.cue | head
package kube

configMap: prometheus: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;ConfigMap&#34;
	metadata: name: &#34;prometheus&#34;
	data: &#123;
		&#34;alert.rules&#34;: &#34;&#34;&#34;
			groups:
			- name: rules.yaml
</code></pre>

The configuration file still contains YAML embedded in a string value of one
of the fields.
The original YAML file might have looked like it was all structured data, but
the majority of it was a string containing, hopefully, valid YAML.

The `-R` option attempts to detect structured YAML or JSON strings embedded
in the configuration files and then converts these recursively.

<-- TODO: update import label format -->

<pre data-command-src="Y3VlIGltcG9ydCAuLy4uLiAtcCBrdWJlIC1sICdzdHJpbmdzLlRvQ2FtZWwoa2luZCknIC1sIG1ldGFkYXRhLm5hbWUgLWYgLVIK"><code class="language-.term1">$ cue import ./... -p kube -l &#39;strings.ToCamel(kind)&#39; -l metadata.name -f -R
</code></pre>

Now the file looks like:

<pre data-command-src="Y2F0IG1vbi9wcm9tZXRoZXVzL2NvbmZpZ21hcC5jdWUgfCBoZWFkCg=="><code class="language-.term1">$ cat mon/prometheus/configmap.cue | head
package kube

import yaml656e63 &#34;encoding/yaml&#34;

configMap: prometheus: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;ConfigMap&#34;
	metadata: name: &#34;prometheus&#34;
	data: &#123;
		&#34;alert.rules&#34;: yaml656e63.Marshal(_cue_alert_rules)
</code></pre>

That looks better!
The resulting configuration file replaces the original embedded string
with a call to `yaml.Marshal` converting a structured CUE source to
a string with an equivalent YAML file.
Fields starting with an underscore (`_`) are not included when emitting
a configuration file (they are when enclosed in double quotes).

<pre data-command-src="Y3VlIGV2YWwgLi9tb24vcHJvbWV0aGV1cyAtZSBjb25maWdNYXAucHJvbWV0aGV1cwo="><code class="language-.term1">$ cue eval ./mon/prometheus -e configMap.prometheus
apiVersion: &#34;v1&#34;
kind:       &#34;ConfigMap&#34;
metadata: &#123;
    name: &#34;prometheus&#34;
&#125;
data: &#123;
    &#34;alert.rules&#34;: &#34;&#34;&#34;
        groups:
        - name: rules.yaml
          rules:
          - alert: InstanceDown
            expr: up == 0
            for: 30s
            labels:
              severity: page
            annotations:
              description: &#39;&#123;&#123;$labels.app&#125;&#125; of job &#123;&#123; $labels.job &#125;&#125; has been down for more
                than 30 seconds.&#39;
              summary: Instance &#123;&#123;$labels.app&#125;&#125; down
          - alert: InsufficientPeers
            expr: count(up&#123;job=&#34;etcd&#34;&#125; == 0) &gt; (count(up&#123;job=&#34;etcd&#34;&#125;) / 2 - 1)
            for: 3m
            labels:
              severity: page
            annotations:
              description: If one more etcd peer goes down the cluster will be unavailable
              summary: etcd cluster small
          - alert: EtcdNoMaster
            expr: sum(etcd_server_has_leader&#123;app=&#34;etcd&#34;&#125;) == 0
            for: 1s
            labels:
              severity: page
            annotations:
              summary: No ETCD master elected.
          - alert: PodRestart
            expr: (max_over_time(pod_container_status_restarts_total[5m]) - min_over_time(pod_container_status_restarts_total[5m]))
              &gt; 2
            for: 1m
            labels:
              severity: page
            annotations:
              description: &#39;&#123;&#123;$labels.app&#125;&#125; &#123;&#123; $labels.container &#125;&#125; resturted &#123;&#123; $value &#125;&#125;
                times in 5m.&#39;
              summary: Pod for &#123;&#123;$labels.container&#125;&#125; restarts too often

        &#34;&#34;&#34;
    &#34;prometheus.yml&#34;: &#34;&#34;&#34;
        global:
          scrape_interval: 15s
        rule_files:
        - /etc/prometheus/alert.rules
        alerting:
          alertmanagers:
          - scheme: http
            static_configs:
            - targets:
              - alertmanager:9093
        scrape_configs:
        - job_name: kubernetes-apiservers
          kubernetes_sd_configs:
          - role: endpoints
          scheme: https
          tls_config:
            ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
          bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
          relabel_configs:
          - source_labels:
            - __meta_kubernetes_namespace
            - __meta_kubernetes_service_name
            - __meta_kubernetes_endpoint_port_name
            action: keep
            regex: default;kubernetes;https
        - job_name: kubernetes-nodes
          scheme: https
          tls_config:
            ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
          bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
          kubernetes_sd_configs:
          - role: node
          relabel_configs:
          - action: labelmap
            regex: __meta_kubernetes_node_label_(.+)
          - target_label: __address__
            replacement: kubernetes.default.svc:443
          - source_labels:
            - __meta_kubernetes_node_name
            regex: (.+)
            target_label: __metrics_path__
            replacement: /api/v1/nodes/$&#123;1&#125;/proxy/metrics
        - job_name: kubernetes-cadvisor
          scheme: https
          tls_config:
            ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
          bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
          kubernetes_sd_configs:
          - role: node
          relabel_configs:
          - action: labelmap
            regex: __meta_kubernetes_node_label_(.+)
          - target_label: __address__
            replacement: kubernetes.default.svc:443
          - source_labels:
            - __meta_kubernetes_node_name
            regex: (.+)
            target_label: __metrics_path__
            replacement: /api/v1/nodes/$&#123;1&#125;/proxy/metrics/cadvisor
        - job_name: kubernetes-service-endpoints
          kubernetes_sd_configs:
          - role: endpoints
          relabel_configs:
          - source_labels:
            - __meta_kubernetes_service_annotation_prometheus_io_scrape
            action: keep
            regex: true
          - source_labels:
            - __meta_kubernetes_service_annotation_prometheus_io_scheme
            action: replace
            target_label: __scheme__
            regex: (https?)
          - source_labels:
            - __meta_kubernetes_service_annotation_prometheus_io_path
            action: replace
            target_label: __metrics_path__
            regex: (.+)
          - source_labels:
            - __address__
            - __meta_kubernetes_service_annotation_prometheus_io_port
            action: replace
            target_label: __address__
            regex: ([^:]+)(?::\\d+)?;(\\d+)
            replacement: $1:$2
          - action: labelmap
            regex: __meta_kubernetes_service_label_(.+)
          - source_labels:
            - __meta_kubernetes_namespace
            action: replace
            target_label: kubernetes_namespace
          - source_labels:
            - __meta_kubernetes_service_name
            action: replace
            target_label: kubernetes_name
        - job_name: kubernetes-services
          metrics_path: /probe
          params:
            module:
            - http_2xx
          kubernetes_sd_configs:
          - role: service
          relabel_configs:
          - source_labels:
            - __meta_kubernetes_service_annotation_prometheus_io_probe
            action: keep
            regex: true
          - source_labels:
            - __address__
            target_label: __param_target
          - target_label: __address__
            replacement: blackbox-exporter.example.com:9115
          - source_labels:
            - __param_target
            target_label: app
          - action: labelmap
            regex: __meta_kubernetes_service_label_(.+)
          - source_labels:
            - __meta_kubernetes_namespace
            target_label: kubernetes_namespace
          - source_labels:
            - __meta_kubernetes_service_name
            target_label: kubernetes_name
        - job_name: kubernetes-ingresses
          metrics_path: /probe
          params:
            module:
            - http_2xx
          kubernetes_sd_configs:
          - role: ingress
          relabel_configs:
          - source_labels:
            - __meta_kubernetes_ingress_annotation_prometheus_io_probe
            action: keep
            regex: true
          - source_labels:
            - __meta_kubernetes_ingress_scheme
            - __address__
            - __meta_kubernetes_ingress_path
            regex: (.+);(.+);(.+)
            replacement: $&#123;1&#125;://$&#123;2&#125;$&#123;3&#125;
            target_label: __param_target
          - target_label: __address__
            replacement: blackbox-exporter.example.com:9115
          - source_labels:
            - __param_target
            target_label: app
          - action: labelmap
            regex: __meta_kubernetes_ingress_label_(.+)
          - source_labels:
            - __meta_kubernetes_namespace
            target_label: kubernetes_namespace
          - source_labels:
            - __meta_kubernetes_ingress_name
            target_label: kubernetes_name
        - job_name: kubernetes-pods
          kubernetes_sd_configs:
          - role: pod
          relabel_configs:
          - source_labels:
            - __meta_kubernetes_pod_annotation_prometheus_io_scrape
            action: keep
            regex: true
          - source_labels:
            - __meta_kubernetes_pod_annotation_prometheus_io_path
            action: replace
            target_label: __metrics_path__
            regex: (.+)
          - source_labels:
            - __address__
            - __meta_kubernetes_pod_annotation_prometheus_io_port
            action: replace
            regex: ([^:]+)(?::\\d+)?;(\\d+)
            replacement: $1:$2
            target_label: __address__
          - action: labelmap
            regex: __meta_kubernetes_pod_label_(.+)
          - source_labels:
            - __meta_kubernetes_namespace
            action: replace
            target_label: kubernetes_namespace
          - source_labels:
            - __meta_kubernetes_pod_name
            action: replace
            target_label: kubernetes_pod_name

        &#34;&#34;&#34;
&#125;
</code></pre>

Yay!


## Quick 'n Dirty Conversion

In this tutorial we show how to quickly eliminate boilerplate from a set
of configurations.
Manual tailoring will usually give better results, but takes considerably
more thought, while taking the quick and dirty approach gets you mostly there.
The result of such a quick conversion also forms a good basis for
a more thoughtful manual optimization.

### Create top-level template

Now we have imported the YAML files we can start the simplification process.

Before we start the restructuring, lets save a full evaluation so that we
can verify that simplifications yield the same results.

<pre data-command-src="Y3VlIGV2YWwgLWMgLi8uLi4gPnNuYXBzaG90Cg=="><code class="language-.term1">$ cue eval -c ./... &gt;snapshot
</code></pre>

The `-c` option tells `cue` that only concrete values, that is valid JSON,
are allowed.
We focus on the objects defined in the various `kube.cue` files.
A quick inspection reveals that many of the Deployments and Services share
common structure.

We copy one of the files containing both as a basis for creating our template
to the root of the directory tree.

<pre data-command-src="Y3AgZnJvbnRlbmQvYnJlYWRkaXNwYXRjaGVyL2t1YmUuY3VlIC4K"><code class="language-.term1">$ cp frontend/breaddispatcher/kube.cue .
</code></pre>

Modify this file as below.

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="a3ViZS5jdWU=:cGFja2FnZSBrdWJlCgpzZXJ2aWNlOiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJ2MSIKCWtpbmQ6ICAgICAgICJTZXJ2aWNlIgoJbWV0YWRhdGE6IHsKCQluYW1lOiBJRAoJCWxhYmVsczogewoJCQlhcHA6ICAgICAgIElEICAgICAvLyBieSBjb252ZW50aW9uCgkJCWRvbWFpbjogICAgInByb2QiIC8vIGFsd2F5cyB0aGUgc2FtZSBpbiB0aGUgZ2l2ZW4gZmlsZXMKCQkJY29tcG9uZW50OiBzdHJpbmcgLy8gdmFyaWVzIHBlciBkaXJlY3RvcnkKCQl9Cgl9CglzcGVjOiB7CgkJLy8gQW55IHBvcnQgaGFzIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllcy4KCQlwb3J0czogWy4uLnsKCQkJcG9ydDogICAgIGludAoJCQlwcm90b2NvbDogKiJUQ1AiIHwgIlVEUCIgLy8gZnJvbSB0aGUgS3ViZXJuZXRlcyBkZWZpbml0aW9uCgkJCW5hbWU6ICAgICBzdHJpbmcgfCAqImNsaWVudCIKCQl9XQoJCXNlbGVjdG9yOiBtZXRhZGF0YS5sYWJlbHMgLy8gd2Ugd2FudCB0aG9zZSB0byBiZSB0aGUgc2FtZQoJfQp9CgpkZXBsb3ltZW50OiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCgltZXRhZGF0YTogbmFtZTogSUQKCXNwZWM6IHsKCQkvLyAxIGlzIHRoZSBkZWZhdWx0LCBidXQgd2UgYWxsb3cgYW55IG51bWJlcgoJCXJlcGxpY2FzOiAqMSB8IGludAoJCXRlbXBsYXRlOiB7CgkJCW1ldGFkYXRhOiBsYWJlbHM6IHsKCQkJCWFwcDogICAgICAgSUQKCQkJCWRvbWFpbjogICAgInByb2QiCgkJCQljb21wb25lbnQ6IHN0cmluZwoJCQl9CgkJCS8vIHdlIGFsd2F5cyBoYXZlIG9uZSBuYW1lc2FrZSBjb250YWluZXIKCQkJc3BlYzogY29udGFpbmVyczogW3tuYW1lOiBJRH1dCgkJfQoJfQp9Cg==" data-upload-term=".term1"><code class="language-cue">package kube

service: [ID=_]: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;Service&#34;
	metadata: &#123;
		name: ID
		labels: &#123;
			app:       ID     // by convention
			domain:    &#34;prod&#34; // always the same in the given files
			component: string // varies per directory
		&#125;
	&#125;
	spec: &#123;
		// Any port has the following properties.
		ports: [...&#123;
			port:     int
			protocol: *&#34;TCP&#34; | &#34;UDP&#34; // from the Kubernetes definition
			name:     string | *&#34;client&#34;
		&#125;]
		selector: metadata.labels // we want those to be the same
	&#125;
&#125;

deployment: [ID=_]: &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;Deployment&#34;
	metadata: name: ID
	spec: &#123;
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: &#123;
			metadata: labels: &#123;
				app:       ID
				domain:    &#34;prod&#34;
				component: string
			&#125;
			// we always have one namesake container
			spec: containers: [&#123;name: ID&#125;]
		&#125;
	&#125;
&#125;
</code></pre>

By replacing the service and deployment name with `[ID=_]` we have changed the
definition into a template matching any field.
CUE bind the field name to `ID` as a result.
During importing we used `metadata.name` as a key for the object names,
so we can now set this field to `ID`.

Templates are applied to (are unified with) all entries in the struct in which
they are defined,
so we need to either strip fields specific to the `breaddispatcher` definition,
generalize them, or remove them.

One of the labels defined in the Kubernetes metadata seems to be always set
to parent directory name.
We enforce this by defining `component: string`, meaning that a field
of name `component` must be set to some string value, and then define this
later on.
Any underspecified field results in an error when converting to, for instance,
JSON.
So a deployment or service will only be valid if this label is defined.

<!-- TODO: once cycles in disjunctions are implemented
    port:       targetPort | int   // by default the same as targetPort
    targetPort: port | int         // by default the same as port

Note that ports definition for service contains a cycle.
Specifying one of the ports will break the cycle.
The meaning of cycles are well-defined in CUE.
In practice this means that a template writer does not have to make any
assumptions about which of the fields that can be mutually derived from each
other a user of the template will want to specify.
-->

Let's compare the result of merging our new template to our original snapshot.

<pre data-command-src="Y3VlIGV2YWwgLWMgLi8uLi4gPnNuYXBzaG90Mgo="><code class="language-.term1">$ cue eval -c ./... &gt;snapshot2
// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/alertmanager
deployment.alertmanager.spec.template.metadata.labels.component: incomplete value string
service.alertmanager.metadata.labels.component: incomplete value string
service.alertmanager.spec.selector.component: incomplete value string
// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/nodeexporter
service.&#34;node-exporter&#34;.metadata.labels.component: incomplete value string
service.&#34;node-exporter&#34;.spec.selector.component: incomplete value string
// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/prometheus
deployment.prometheus.spec.template.metadata.labels.component: incomplete value string
service.prometheus.metadata.labels.component: incomplete value string
service.prometheus.spec.selector.component: incomplete value string
// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/proxy/authproxy
deployment.authproxy.spec.template.metadata.labels.component: incomplete value string
service.authproxy.metadata.labels.component: incomplete value string
service.authproxy.spec.selector.component: incomplete value string
</code></pre>

<!-- TODO: better error messages -->

Oops.
The alert manager does not specify the `component` label.
This demonstrates how constraints can be used to catch inconsistencies
in your configurations.

As there are very few objects that do not specify this label, we will modify
the configurations to include them everywhere.
We do this by setting a newly defined top-level field in each directory
to the directory name and modify our master template file to use it.

Set the component label to our new top-level field, and add the new top-level
field to our previous template definitions:

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="a3ViZS5jdWU=:cGFja2FnZSBrdWJlCgpzZXJ2aWNlOiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJ2MSIKCWtpbmQ6ICAgICAgICJTZXJ2aWNlIgoJbWV0YWRhdGE6IHsKCQluYW1lOiBJRAoJCWxhYmVsczogewoJCQlhcHA6ICAgICAgIElEICAgICAgICAgLy8gYnkgY29udmVudGlvbgoJCQlkb21haW46ICAgICJwcm9kIiAgICAgLy8gYWx3YXlzIHRoZSBzYW1lIGluIHRoZSBnaXZlbiBmaWxlcwoJCQljb21wb25lbnQ6ICNDb21wb25lbnQgLy8gdmFyaWVzIHBlciBkaXJlY3RvcnkKCQl9Cgl9CglzcGVjOiB7CgkJLy8gQW55IHBvcnQgaGFzIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllcy4KCQlwb3J0czogWy4uLnsKCQkJcG9ydDogICAgIGludAoJCQlwcm90b2NvbDogKiJUQ1AiIHwgIlVEUCIgLy8gZnJvbSB0aGUgS3ViZXJuZXRlcyBkZWZpbml0aW9uCgkJCW5hbWU6ICAgICBzdHJpbmcgfCAqImNsaWVudCIKCQl9XQoJCXNlbGVjdG9yOiBtZXRhZGF0YS5sYWJlbHMgLy8gd2Ugd2FudCB0aG9zZSB0byBiZSB0aGUgc2FtZQoJfQp9CgpkZXBsb3ltZW50OiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCgltZXRhZGF0YTogbmFtZTogSUQKCXNwZWM6IHsKCQkvLyAxIGlzIHRoZSBkZWZhdWx0LCBidXQgd2UgYWxsb3cgYW55IG51bWJlcgoJCXJlcGxpY2FzOiAqMSB8IGludAoJCXRlbXBsYXRlOiB7CgkJCW1ldGFkYXRhOiBsYWJlbHM6IHsKCQkJCWFwcDogICAgICAgSUQKCQkJCWRvbWFpbjogICAgInByb2QiCgkJCQljb21wb25lbnQ6ICNDb21wb25lbnQKCQkJfQoJCQkvLyB3ZSBhbHdheXMgaGF2ZSBvbmUgbmFtZXNha2UgY29udGFpbmVyCgkJCXNwZWM6IGNvbnRhaW5lcnM6IFt7bmFtZTogSUR9XQoJCX0KCX0KfQoKI0NvbXBvbmVudDogc3RyaW5nCg==" data-upload-term=".term1"><code class="language-cue">package kube

service: [ID=_]: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;Service&#34;
	metadata: &#123;
		name: ID
		labels: &#123;
<b>			app:       ID         // by convention</b>
<b>			domain:    &#34;prod&#34;     // always the same in the given files</b>
<b>			component: #Component // varies per directory</b>
		&#125;
	&#125;
	spec: &#123;
		// Any port has the following properties.
		ports: [...&#123;
			port:     int
			protocol: *&#34;TCP&#34; | &#34;UDP&#34; // from the Kubernetes definition
			name:     string | *&#34;client&#34;
		&#125;]
		selector: metadata.labels // we want those to be the same
	&#125;
&#125;

deployment: [ID=_]: &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;Deployment&#34;
	metadata: name: ID
	spec: &#123;
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: &#123;
			metadata: labels: &#123;
				app:       ID
				domain:    &#34;prod&#34;
<b>				component: #Component</b>
			&#125;
			// we always have one namesake container
			spec: containers: [&#123;name: ID&#125;]
		&#125;
	&#125;
&#125;
<b></b>
<b>#Component: string</b>
</code></pre>

Add a file with the component label to each directory:

<pre data-command-src="bHMgLWQgKi8gfCBzZWQgJ3MvLiQvLycgfCB4YXJncyAtSSBESVIgc2ggLWMgJ2NkIERJUjsgZWNobyAicGFja2FnZSBrdWJlCgojQ29tcG9uZW50OiBcIkRJUlwiCiIgPiBrdWJlLmN1ZTsgY2QgLi4nCg=="><code class="language-.term1">$ ls -d */ | sed &#39;s/.$//&#39; | xargs -I DIR sh -c &#39;cd DIR; echo &#34;package kube

#Component: \&#34;DIR\&#34;
&#34; &gt; kube.cue; cd ..&#39;
</code></pre>

Format the CUE files:

<pre data-command-src="Y3VlIGZtdCBrdWJlLmN1ZSAqL2t1YmUuY3VlCg=="><code class="language-.term1">$ cue fmt kube.cue */kube.cue
</code></pre>

Let's try again to see if it is fixed:

<pre data-command-src="Y3VlIGV2YWwgLWMgLi8uLi4gPnNuYXBzaG90MgpkaWZmIC13dSBzbmFwc2hvdCBzbmFwc2hvdDIK"><code class="language-.term1">$ cue eval -c ./... &gt;snapshot2
$ diff -wu snapshot snapshot2
--- snapshot	2021-03-11 11:19:38.131545599 +0000
+++ snapshot2	2021-03-11 11:19:41.287414542 +0000
@@ -1,3 +1,9 @@
+service: &#123;&#125;
+deployment: &#123;&#125;
+// ---
+service: &#123;&#125;
+deployment: &#123;&#125;
+// ---
 service: &#123;
     bartender: &#123;
         apiVersion: &#34;v1&#34;
@@ -208,6 +214,7 @@
             selector: &#123;
                 app:    &#34;maitred&#34;
                 domain: &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -270,6 +277,7 @@
             selector: &#123;
                 app:    &#34;valeter&#34;
                 domain: &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -330,6 +338,8 @@
             &#125;]
             selector: &#123;
                 app: &#34;waiter&#34;
+                component: &#34;frontend&#34;
+                domain:    &#34;prod&#34;
             &#125;
         &#125;
     &#125;
@@ -432,6 +442,9 @@
     &#125;
 &#125;
 // ---
+service: &#123;&#125;
+deployment: &#123;&#125;
+// ---
 service: &#123;
     download: &#123;
         apiVersion: &#34;v1&#34;
@@ -454,6 +467,7 @@
             selector: &#123;
                 app:    &#34;download&#34;
                 domain: &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
     &#125;
@@ -497,6 +511,7 @@
             name: &#34;etcd&#34;
             labels: &#123;
                 app:       &#34;etcd&#34;
+                domain:    &#34;prod&#34;
                 component: &#34;infra&#34;
             &#125;
         &#125;
@@ -504,6 +519,8 @@
             clusterIP: &#34;None&#34;
             selector: &#123;
                 app: &#34;etcd&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
             ports: [&#123;
                 port:       2379
@@ -519,6 +536,7 @@
         &#125;
     &#125;
 &#125;
+deployment: &#123;&#125;
 statefulSet: &#123;
     etcd: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -712,6 +730,35 @@
     &#125;
 &#125;
 // ---
+service: &#123;
+    tasks: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;Service&#34;
+        metadata: &#123;
+            name: &#34;tasks&#34;
+            labels: &#123;
+                app:       &#34;tasks&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
+        spec: &#123;
+            type:           &#34;LoadBalancer&#34;
+            loadBalancerIP: &#34;1.2.3.4&#34;
+            ports: [&#123;
+                port:       443
+                targetPort: 7443
+                protocol:   &#34;TCP&#34;
+                name:       &#34;http&#34;
+            &#125;]
+            selector: &#123;
+                app:       &#34;tasks&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
+    &#125;
+&#125;
 deployment: &#123;
     tasks: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -725,6 +772,7 @@
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;tasks&#34;
+                        domain:    &#34;prod&#34;
                         component: &#34;infra&#34;
                     &#125;
                     annotations: &#123;
@@ -757,32 +805,6 @@
         &#125;
     &#125;
 &#125;
-service: &#123;
-    tasks: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;Service&#34;
-        metadata: &#123;
-            name: &#34;tasks&#34;
-            labels: &#123;
-                app:       &#34;tasks&#34;
-                component: &#34;infra&#34;
-            &#125;
-        &#125;
-        spec: &#123;
-            type:           &#34;LoadBalancer&#34;
-            loadBalancerIP: &#34;1.2.3.4&#34;
-            ports: [&#123;
-                port:       443
-                targetPort: 7443
-                protocol:   &#34;TCP&#34;
-                name:       &#34;http&#34;
-            &#125;]
-            selector: &#123;
-                app: &#34;tasks&#34;
-            &#125;
-        &#125;
-    &#125;
-&#125;
 // ---
 service: &#123;
     updater: &#123;
@@ -806,6 +828,7 @@
             selector: &#123;
                 app:    &#34;updater&#34;
                 domain: &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
     &#125;
@@ -852,6 +875,35 @@
     &#125;
 &#125;
 // ---
+service: &#123;
+    watcher: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;Service&#34;
+        metadata: &#123;
+            name: &#34;watcher&#34;
+            labels: &#123;
+                app:       &#34;watcher&#34;
+                component: &#34;infra&#34;
+                domain:    &#34;prod&#34;
+            &#125;
+        &#125;
+        spec: &#123;
+            type:           &#34;LoadBalancer&#34;
+            loadBalancerIP: &#34;1.2.3.4.&#34;
+            ports: [&#123;
+                port:       7788
+                targetPort: 7788
+                protocol:   &#34;TCP&#34;
+                name:       &#34;http&#34;
+            &#125;]
+            selector: &#123;
+                app:       &#34;watcher&#34;
+                component: &#34;infra&#34;
+                domain:    &#34;prod&#34;
+            &#125;
+        &#125;
+    &#125;
+&#125;
 deployment: &#123;
     watcher: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -894,33 +946,9 @@
         &#125;
     &#125;
 &#125;
-service: &#123;
-    watcher: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;Service&#34;
-        metadata: &#123;
-            name: &#34;watcher&#34;
-            labels: &#123;
-                app:       &#34;watcher&#34;
-                component: &#34;infra&#34;
-                domain:    &#34;prod&#34;
-            &#125;
-        &#125;
-        spec: &#123;
-            type:           &#34;LoadBalancer&#34;
-            loadBalancerIP: &#34;1.2.3.4.&#34;
-            ports: [&#123;
-                port:       7788
-                targetPort: 7788
-                protocol:   &#34;TCP&#34;
-                name:       &#34;http&#34;
-            &#125;]
-            selector: &#123;
-                app: &#34;watcher&#34;
-            &#125;
-        &#125;
-    &#125;
-&#125;
+// ---
+service: &#123;&#125;
+deployment: &#123;&#125;
 // ---
 service: &#123;
     caller: &#123;
@@ -944,6 +972,7 @@
             selector: &#123;
                 app:    &#34;caller&#34;
                 domain: &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1500,6 +1529,8 @@
             &#125;]
             selector: &#123;
                 app: &#34;souschef&#34;
+                component: &#34;kitchen&#34;
+                domain:    &#34;prod&#34;
             &#125;
         &#125;
     &#125;
@@ -1543,33 +1574,9 @@
     &#125;
 &#125;
 // ---
-configMap: &#123;
-    alertmanager: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;ConfigMap&#34;
-        metadata: &#123;
-            name: &#34;alertmanager&#34;
-        &#125;
-        data: &#123;
-            &#34;alerts.yaml&#34;: &#34;&#34;&#34;
-                receivers:
-                - name: pager
-                  slack_configs:
-                  - channel: &#39;#cloudmon&#39;
-                    text: |-
-                      &#123;&#123; range .Alerts &#125;&#125;&#123;&#123; .Annotations.description &#125;&#125;
-                      &#123;&#123; end &#125;&#125;
-                    send_resolved: true
-                route:
-                  receiver: pager
-                  group_by:
-                  - alertname
-                  - cluster
-
-                &#34;&#34;&#34;
-        &#125;
-    &#125;
-&#125;
+service: &#123;&#125;
+deployment: &#123;&#125;
+// ---
 service: &#123;
     alertmanager: &#123;
         apiVersion: &#34;v1&#34;
@@ -1581,12 +1588,18 @@
             &#125;
             labels: &#123;
                 name: &#34;alertmanager&#34;
+                app:       &#34;alertmanager&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
             &#125;
             name: &#34;alertmanager&#34;
         &#125;
         spec: &#123;
             selector: &#123;
                 app: &#34;alertmanager&#34;
+                name:      &#34;alertmanager&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
             &#125;
             ports: [&#123;
                 name:       &#34;main&#34;
@@ -1597,6 +1610,33 @@
         &#125;
     &#125;
 &#125;
+configMap: &#123;
+    alertmanager: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;ConfigMap&#34;
+        metadata: &#123;
+            name: &#34;alertmanager&#34;
+        &#125;
+        data: &#123;
+            &#34;alerts.yaml&#34;: &#34;&#34;&#34;
+                receivers:
+                - name: pager
+                  slack_configs:
+                  - channel: &#39;#cloudmon&#39;
+                    text: |-
+                      &#123;&#123; range .Alerts &#125;&#125;&#123;&#123; .Annotations.description &#125;&#125;
+                      &#123;&#123; end &#125;&#125;
+                    send_resolved: true
+                route:
+                  receiver: pager
+                  group_by:
+                  - alertname
+                  - cluster
+
+                &#34;&#34;&#34;
+        &#125;
+    &#125;
+&#125;
 deployment: &#123;
     alertmanager: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -1616,6 +1656,8 @@
                     name: &#34;alertmanager&#34;
                     labels: &#123;
                         app: &#34;alertmanager&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;mon&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1650,6 +1692,33 @@
     &#125;
 &#125;
 // ---
+service: &#123;
+    grafana: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;Service&#34;
+        metadata: &#123;
+            name: &#34;grafana&#34;
+            labels: &#123;
+                app:       &#34;grafana&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
+        &#125;
+        spec: &#123;
+            selector: &#123;
+                app:       &#34;grafana&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
+            ports: [&#123;
+                name:       &#34;grafana&#34;
+                protocol:   &#34;TCP&#34;
+                port:       3000
+                targetPort: 3000
+            &#125;]
+        &#125;
+    &#125;
+&#125;
 deployment: &#123;
     grafana: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -1667,6 +1736,7 @@
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;grafana&#34;
+                        domain:    &#34;prod&#34;
                         component: &#34;mon&#34;
                     &#125;
                 &#125;
@@ -1714,31 +1784,6 @@
         &#125;
     &#125;
 &#125;
-service: &#123;
-    grafana: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;Service&#34;
-        metadata: &#123;
-            name: &#34;grafana&#34;
-            labels: &#123;
-                app:       &#34;grafana&#34;
-                component: &#34;mon&#34;
-            &#125;
-        &#125;
-        spec: &#123;
-            selector: &#123;
-                app:       &#34;grafana&#34;
-                component: &#34;mon&#34;
-            &#125;
-            ports: [&#123;
-                name:       &#34;grafana&#34;
-                protocol:   &#34;TCP&#34;
-                port:       3000
-                targetPort: 3000
-            &#125;]
-        &#125;
-    &#125;
-&#125;
 // ---
 service: &#123;
     &#34;node-exporter&#34;: &#123;
@@ -1747,6 +1792,8 @@
         metadata: &#123;
             labels: &#123;
                 app: &#34;node-exporter&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
             &#125;
             annotations: &#123;
                 &#34;prometheus.io/scrape&#34;: &#34;true&#34;
@@ -1763,10 +1810,13 @@
             &#125;]
             selector: &#123;
                 app: &#34;node-exporter&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
             &#125;
         &#125;
     &#125;
 &#125;
+deployment: &#123;&#125;
 daemonSet: &#123;
     &#34;node-exporter&#34;: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -1831,6 +1881,39 @@
     &#125;
 &#125;
 // ---
+service: &#123;
+    prometheus: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;Service&#34;
+        metadata: &#123;
+            annotations: &#123;
+                &#34;prometheus.io/scrape&#34;: &#34;true&#34;
+            &#125;
+            labels: &#123;
+                name:      &#34;prometheus&#34;
+                app:       &#34;prometheus&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
+            name: &#34;prometheus&#34;
+        &#125;
+        spec: &#123;
+            selector: &#123;
+                app:       &#34;prometheus&#34;
+                name:      &#34;prometheus&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
+            type: &#34;NodePort&#34;
+            ports: [&#123;
+                name:     &#34;main&#34;
+                protocol: &#34;TCP&#34;
+                port:     9090
+                nodePort: 30900
+            &#125;]
+        &#125;
+    &#125;
+&#125;
 configMap: &#123;
     prometheus: &#123;
         apiVersion: &#34;v1&#34;
@@ -2069,33 +2152,6 @@
         &#125;
     &#125;
 &#125;
-service: &#123;
-    prometheus: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;Service&#34;
-        metadata: &#123;
-            annotations: &#123;
-                &#34;prometheus.io/scrape&#34;: &#34;true&#34;
-            &#125;
-            labels: &#123;
-                name: &#34;prometheus&#34;
-            &#125;
-            name: &#34;prometheus&#34;
-        &#125;
-        spec: &#123;
-            selector: &#123;
-                app: &#34;prometheus&#34;
-            &#125;
-            type: &#34;NodePort&#34;
-            ports: [&#123;
-                name:     &#34;main&#34;
-                protocol: &#34;TCP&#34;
-                port:     9090
-                nodePort: 30900
-            &#125;]
-        &#125;
-    &#125;
-&#125;
 deployment: &#123;
     prometheus: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -2122,6 +2178,8 @@
                     name: &#34;prometheus&#34;
                     labels: &#123;
                         app: &#34;prometheus&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;mon&#34;
                     &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
@@ -2153,6 +2211,77 @@
     &#125;
 &#125;
 // ---
+service: &#123;&#125;
+deployment: &#123;&#125;
+// ---
+service: &#123;
+    authproxy: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;Service&#34;
+        metadata: &#123;
+            name: &#34;authproxy&#34;
+            labels: &#123;
+                app:       &#34;authproxy&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
+        spec: &#123;
+            ports: [&#123;
+                port:       4180
+                targetPort: 4180
+                protocol:   &#34;TCP&#34;
+                name:       &#34;client&#34;
+            &#125;]
+            selector: &#123;
+                app:       &#34;authproxy&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
+    &#125;
+&#125;
+deployment: &#123;
+    authproxy: &#123;
+        apiVersion: &#34;apps/v1&#34;
+        kind:       &#34;Deployment&#34;
+        metadata: &#123;
+            name: &#34;authproxy&#34;
+        &#125;
+        spec: &#123;
+            replicas: 1
+            template: &#123;
+                metadata: &#123;
+                    labels: &#123;
+                        app:       &#34;authproxy&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;proxy&#34;
+                    &#125;
+                &#125;
+                spec: &#123;
+                    containers: [&#123;
+                        name:  &#34;authproxy&#34;
+                        image: &#34;skippy/oauth2_proxy:2.0.1&#34;
+                        ports: [&#123;
+                            containerPort: 4180
+                        &#125;]
+                        args: [&#34;--config=/etc/authproxy/authproxy.cfg&#34;]
+                        volumeMounts: [&#123;
+                            name:      &#34;config-volume&#34;
+                            mountPath: &#34;/etc/authproxy&#34;
+                        &#125;]
+                    &#125;]
+                    volumes: [&#123;
+                        name: &#34;config-volume&#34;
+                        configMap: &#123;
+                            name: &#34;authproxy&#34;
+                        &#125;
+                    &#125;]
+                &#125;
+            &#125;
+        &#125;
+    &#125;
+&#125;
 configMap: &#123;
     authproxy: &#123;
         apiVersion: &#34;v1&#34;
@@ -2217,71 +2346,36 @@
         &#125;
     &#125;
 &#125;
-deployment: &#123;
-    authproxy: &#123;
-        apiVersion: &#34;apps/v1&#34;
-        kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;authproxy&#34;
-        &#125;
-        spec: &#123;
-            replicas: 1
-            template: &#123;
-                metadata: &#123;
-                    labels: &#123;
-                        app:    &#34;authproxy&#34;
-                        domain: &#34;prod&#34;
-                    &#125;
-                &#125;
-                spec: &#123;
-                    containers: [&#123;
-                        name:  &#34;authproxy&#34;
-                        image: &#34;skippy/oauth2_proxy:2.0.1&#34;
-                        ports: [&#123;
-                            containerPort: 4180
-                        &#125;]
-                        args: [&#34;--config=/etc/authproxy/authproxy.cfg&#34;]
-                        volumeMounts: [&#123;
-                            name:      &#34;config-volume&#34;
-                            mountPath: &#34;/etc/authproxy&#34;
-                        &#125;]
-                    &#125;]
-                    volumes: [&#123;
-                        name: &#34;config-volume&#34;
-                        configMap: &#123;
-                            name: &#34;authproxy&#34;
-                        &#125;
-                    &#125;]
-                &#125;
-            &#125;
-        &#125;
-    &#125;
-&#125;
+// ---
 service: &#123;
-    authproxy: &#123;
+    goget: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;Service&#34;
         metadata: &#123;
-            name: &#34;authproxy&#34;
+            name: &#34;goget&#34;
             labels: &#123;
-                app:    &#34;authproxy&#34;
+                app:       &#34;goget&#34;
                 domain: &#34;prod&#34;
+                component: &#34;proxy&#34;
             &#125;
         &#125;
         spec: &#123;
+            type:           &#34;LoadBalancer&#34;
+            loadBalancerIP: &#34;1.3.5.7&#34;
             ports: [&#123;
-                port:       4180
-                targetPort: 4180
+                port:       443
+                targetPort: 7443
                 protocol:   &#34;TCP&#34;
-                name:       &#34;client&#34;
+                name:       &#34;https&#34;
             &#125;]
             selector: &#123;
-                app: &#34;authproxy&#34;
+                app:       &#34;goget&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;proxy&#34;
             &#125;
         &#125;
     &#125;
 &#125;
-// ---
 deployment: &#123;
     goget: &#123;
         apiVersion: &#34;apps/v1&#34;
@@ -2295,6 +2389,7 @@
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;goget&#34;
+                        domain:    &#34;prod&#34;
                         component: &#34;proxy&#34;
                     &#125;
                 &#125;
@@ -2321,33 +2416,91 @@
         &#125;
     &#125;
 &#125;
+// ---
 service: &#123;
-    goget: &#123;
+    nginx: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;Service&#34;
         metadata: &#123;
-            name: &#34;goget&#34;
+            name: &#34;nginx&#34;
             labels: &#123;
-                app:       &#34;goget&#34;
+                app:       &#34;nginx&#34;
+                domain:    &#34;prod&#34;
                 component: &#34;proxy&#34;
             &#125;
         &#125;
         spec: &#123;
             type:           &#34;LoadBalancer&#34;
-            loadBalancerIP: &#34;1.3.5.7&#34;
+            loadBalancerIP: &#34;1.3.4.5&#34;
             ports: [&#123;
+                port:       80
+                targetPort: 80
+                protocol:   &#34;TCP&#34;
+                name:       &#34;http&#34;
+            &#125;, &#123;
                 port:       443
-                targetPort: 7443
                 protocol:   &#34;TCP&#34;
                 name:       &#34;https&#34;
             &#125;]
             selector: &#123;
-                app: &#34;goget&#34;
+                app:       &#34;nginx&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
+    &#125;
+&#125;
+deployment: &#123;
+    nginx: &#123;
+        apiVersion: &#34;apps/v1&#34;
+        kind:       &#34;Deployment&#34;
+        metadata: &#123;
+            name: &#34;nginx&#34;
+        &#125;
+        spec: &#123;
+            replicas: 1
+            template: &#123;
+                metadata: &#123;
+                    labels: &#123;
+                        app:       &#34;nginx&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;proxy&#34;
+                    &#125;
+                &#125;
+                spec: &#123;
+                    volumes: [&#123;
+                        name: &#34;secret-volume&#34;
+                        secret: &#123;
+                            secretName: &#34;proxy-secrets&#34;
+                        &#125;
+                    &#125;, &#123;
+                        name: &#34;config-volume&#34;
+                        configMap: &#123;
+                            name: &#34;nginx&#34;
+                        &#125;
+                    &#125;]
+                    containers: [&#123;
+                        name:  &#34;nginx&#34;
+                        image: &#34;nginx:1.11.10-alpine&#34;
+                        ports: [&#123;
+                            containerPort: 80
+                        &#125;, &#123;
+                            containerPort: 443
+                        &#125;]
+                        volumeMounts: [&#123;
+                            mountPath: &#34;/etc/ssl&#34;
+                            name:      &#34;secret-volume&#34;
+                        &#125;, &#123;
+                            name:      &#34;config-volume&#34;
+                            mountPath: &#34;/etc/nginx/nginx.conf&#34;
+                            subPath:   &#34;nginx.conf&#34;
+                        &#125;]
+                    &#125;]
+                &#125;
             &#125;
         &#125;
     &#125;
 &#125;
-// ---
 configMap: &#123;
     nginx: &#123;
         apiVersion: &#34;v1&#34;
@@ -2513,83 +2666,3 @@
         &#125;
     &#125;
 &#125;
-deployment: &#123;
-    nginx: &#123;
-        apiVersion: &#34;apps/v1&#34;
-        kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;nginx&#34;
-        &#125;
-        spec: &#123;
-            replicas: 1
-            template: &#123;
-                metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;nginx&#34;
-                        component: &#34;proxy&#34;
-                    &#125;
-                &#125;
-                spec: &#123;
-                    volumes: [&#123;
-                        name: &#34;secret-volume&#34;
-                        secret: &#123;
-                            secretName: &#34;proxy-secrets&#34;
-                        &#125;
-                    &#125;, &#123;
-                        name: &#34;config-volume&#34;
-                        configMap: &#123;
-                            name: &#34;nginx&#34;
-                        &#125;
-                    &#125;]
-                    containers: [&#123;
-                        name:  &#34;nginx&#34;
-                        image: &#34;nginx:1.11.10-alpine&#34;
-                        ports: [&#123;
-                            containerPort: 80
-                        &#125;, &#123;
-                            containerPort: 443
-                        &#125;]
-                        volumeMounts: [&#123;
-                            mountPath: &#34;/etc/ssl&#34;
-                            name:      &#34;secret-volume&#34;
-                        &#125;, &#123;
-                            name:      &#34;config-volume&#34;
-                            mountPath: &#34;/etc/nginx/nginx.conf&#34;
-                            subPath:   &#34;nginx.conf&#34;
-                        &#125;]
-                    &#125;]
-                &#125;
-            &#125;
-        &#125;
-    &#125;
-&#125;
-service: &#123;
-    nginx: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;Service&#34;
-        metadata: &#123;
-            name: &#34;nginx&#34;
-            labels: &#123;
-                app:       &#34;nginx&#34;
-                component: &#34;proxy&#34;
-            &#125;
-        &#125;
-        spec: &#123;
-            type:           &#34;LoadBalancer&#34;
-            loadBalancerIP: &#34;1.3.4.5&#34;
-            ports: [&#123;
-                port:       80
-                targetPort: 80
-                protocol:   &#34;TCP&#34;
-                name:       &#34;http&#34;
-            &#125;, &#123;
-                port:     443
-                protocol: &#34;TCP&#34;
-                name:     &#34;https&#34;
-            &#125;]
-            selector: &#123;
-                app: &#34;nginx&#34;
-            &#125;
-        &#125;
-    &#125;
-&#125;
</code></pre>

Except for having more consistent labels and some reordering, nothing changed.
We are happy and save the result as the new baseline.

<pre data-command-src="Y3Agc25hcHNob3QyIHNuYXBzaG90Cg=="><code class="language-.term1">$ cp snapshot2 snapshot
</code></pre>

The corresponding boilerplate can now be removed with `cue trim`.

<pre data-command-src="ZmluZCAuIHwgZ3JlcCBrdWJlLmN1ZSB8IHhhcmdzIHdjIHwgdGFpbCAtMQpjdWUgdHJpbSAuLy4uLgpmaW5kIC4gfCBncmVwIGt1YmUuY3VlIHwgeGFyZ3Mgd2MgfCB0YWlsIC0xCg=="><code class="language-.term1">$ find . | grep kube.cue | xargs wc | tail -1
 1889  3631 35031 total
$ cue trim ./...
$ find . | grep kube.cue | xargs wc | tail -1
 1322  2412 23557 total
</code></pre>

`cue trim` removes configuration from files that is already generated
by templates or comprehensions.
In doing so it removed over 500 lines of configuration, or over 30%!

The following is proof that nothing changed semantically:

<pre data-command-src="Y3VlIGV2YWwgLWMgLi8uLi4gPnNuYXBzaG90MgpkaWZmIHNuYXBzaG90IHNuYXBzaG90Mgo="><code class="language-.term1">$ cue eval -c ./... &gt;snapshot2
$ diff snapshot snapshot2
14d13
&lt;                 component: &#34;frontend&#34;
16a16
&gt;                 component: &#34;frontend&#34;
22d21
&lt;                 targetPort: 7080
23a23
&gt;                 targetPort: 7080
27d26
&lt;                 component: &#34;frontend&#34;
29a29
&gt;                 component: &#34;frontend&#34;
45,49d44
&lt;                     labels: &#123;
&lt;                         component: &#34;frontend&#34;
&lt;                         app:       &#34;bartender&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
53a49,53
&gt;                     labels: &#123;
&gt;                         app:       &#34;bartender&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;frontend&#34;
&gt;                     &#125;
57d56
&lt;                         name:  &#34;bartender&#34;
61a61
&gt;                         name: &#34;bartender&#34;
78d77
&lt;                 component: &#34;frontend&#34;
79a79
&gt;                 component: &#34;frontend&#34;
85d84
&lt;                 targetPort: 7080
86a86
&gt;                 targetPort: 7080
91d90
&lt;                 component: &#34;frontend&#34;
92a92
&gt;                 component: &#34;frontend&#34;
108,112d107
&lt;                     labels: &#123;
&lt;                         app:       &#34;breaddispatcher&#34;
&lt;                         component: &#34;frontend&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
116a112,116
&gt;                     labels: &#123;
&gt;                         app:       &#34;breaddispatcher&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;frontend&#34;
&gt;                     &#125;
120d119
&lt;                         name:  &#34;breaddispatcher&#34;
124a124
&gt;                         name: &#34;breaddispatcher&#34;
141d140
&lt;                 component: &#34;frontend&#34;
142a142
&gt;                 component: &#34;frontend&#34;
148d147
&lt;                 targetPort: 7080
149a149
&gt;                 targetPort: 7080
154d153
&lt;                 component: &#34;frontend&#34;
155a155
&gt;                 component: &#34;frontend&#34;
170a171,173
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
173d175
&lt;                         component: &#34;frontend&#34;
175,177c177
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;frontend&#34;
182d181
&lt;                         name:  &#34;host&#34;
186a186
&gt;                         name: &#34;host&#34;
203d202
&lt;                 component: &#34;frontend&#34;
204a204
&gt;                 component: &#34;frontend&#34;
210d209
&lt;                 targetPort: 7080
211a211
&gt;                 targetPort: 7080
233,237d232
&lt;                     labels: &#123;
&lt;                         app:       &#34;maitred&#34;
&lt;                         component: &#34;frontend&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
241a237,241
&gt;                     labels: &#123;
&gt;                         app:       &#34;maitred&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;frontend&#34;
&gt;                     &#125;
245d244
&lt;                         name:  &#34;maitred&#34;
249a249
&gt;                         name: &#34;maitred&#34;
265d264
&lt;                 component: &#34;frontend&#34;
267a267
&gt;                 component: &#34;frontend&#34;
295a296,298
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
297d299
&lt;                         component: &#34;frontend&#34;
300,302c302
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;frontend&#34;
307d306
&lt;                         name:  &#34;valeter&#34;
311a311
&gt;                         name: &#34;valeter&#34;
327d326
&lt;                 component: &#34;frontend&#34;
329a329
&gt;                 component: &#34;frontend&#34;
335d334
&lt;                 targetPort: 7080
336a336
&gt;                 targetPort: 7080
341d340
&lt;                 component: &#34;frontend&#34;
342a342
&gt;                 component: &#34;frontend&#34;
358,362d357
&lt;                     labels: &#123;
&lt;                         component: &#34;frontend&#34;
&lt;                         app:       &#34;waiter&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
366a362,366
&gt;                     labels: &#123;
&gt;                         app:       &#34;waiter&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;frontend&#34;
&gt;                     &#125;
370d369
&lt;                         name:  &#34;waiter&#34;
371a371
&gt;                         name:  &#34;waiter&#34;
390d389
&lt;                 component: &#34;frontend&#34;
391a391
&gt;                 component: &#34;frontend&#34;
403d402
&lt;                 component: &#34;frontend&#34;
404a404
&gt;                 component: &#34;frontend&#34;
420,424d419
&lt;                     labels: &#123;
&lt;                         app:       &#34;waterdispatcher&#34;
&lt;                         component: &#34;frontend&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
428a424,428
&gt;                     labels: &#123;
&gt;                         app:       &#34;waterdispatcher&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;frontend&#34;
&gt;                     &#125;
432d431
&lt;                         name:  &#34;waterdispatcher&#34;
436a436
&gt;                         name: &#34;waterdispatcher&#34;
456d455
&lt;                 component: &#34;infra&#34;
457a457
&gt;                 component: &#34;infra&#34;
463d462
&lt;                 targetPort: 7080
464a464
&gt;                 targetPort: 7080
488d487
&lt;                         component: &#34;infra&#34;
489a489
&gt;                         component: &#34;infra&#34;
494d493
&lt;                         name:  &#34;download&#34;
495a495
&gt;                         name:  &#34;download&#34;
520,524d519
&lt;             selector: &#123;
&lt;                 app:       &#34;etcd&#34;
&lt;                 domain:    &#34;prod&#34;
&lt;                 component: &#34;infra&#34;
&lt;             &#125;
527d521
&lt;                 targetPort: 2379
528a523
&gt;                 targetPort: 2379
535a531,535
&gt;             selector: &#123;
&gt;                 app:       &#34;etcd&#34;
&gt;                 domain:    &#34;prod&#34;
&gt;                 component: &#34;infra&#34;
&gt;             &#125;
652d651
&lt;                 component: &#34;infra&#34;
653a653
&gt;                 component: &#34;infra&#34;
665d664
&lt;                 component: &#34;infra&#34;
666a666
&gt;                 component: &#34;infra&#34;
682,686d681
&lt;                     labels: &#123;
&lt;                         app:       &#34;events&#34;
&lt;                         component: &#34;infra&#34;
&lt;                         domain:    &#34;prod&#34;
&lt;                     &#125;
690a686,690
&gt;                     labels: &#123;
&gt;                         app:       &#34;events&#34;
&gt;                         domain:    &#34;prod&#34;
&gt;                         component: &#34;infra&#34;
&gt;                     &#125;
714d713
&lt;                         name:  &#34;events&#34;
721a721
&gt;                         name: &#34;events&#34;
772a773,776
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
778,781d781
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
791d790
&lt;                         name:  &#34;tasks&#34;
797a797
&gt;                         name: &#34;tasks&#34;
817d816
&lt;                 component: &#34;infra&#34;
818a818
&gt;                 component: &#34;infra&#34;
824d823
&lt;                 targetPort: 8080
825a825
&gt;                 targetPort: 8080
849d848
&lt;                         component: &#34;infra&#34;
850a850
&gt;                         component: &#34;infra&#34;
861d860
&lt;                         name:  &#34;updater&#34;
869a869
&gt;                         name: &#34;updater&#34;
886d885
&lt;                 component: &#34;infra&#34;
887a887
&gt;                 component: &#34;infra&#34;
901d900
&lt;                 component: &#34;infra&#34;
902a902
&gt;                 component: &#34;infra&#34;
920d919
&lt;                         component: &#34;infra&#34;
921a921
&gt;                         component: &#34;infra&#34;
932d931
&lt;                         name:  &#34;watcher&#34;
938a938
&gt;                         name: &#34;watcher&#34;
961d960
&lt;                 component: &#34;kitchen&#34;
962a962
&gt;                 component: &#34;kitchen&#34;
968d967
&lt;                 targetPort: 8080
969a969
&gt;                 targetPort: 8080
990a991,993
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
993d995
&lt;                         component: &#34;kitchen&#34;
995,997c997
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1019d1018
&lt;                         name:  &#34;caller&#34;
1036a1036
&gt;                         name: &#34;caller&#34;
1060d1059
&lt;                 component: &#34;kitchen&#34;
1061a1061
&gt;                 component: &#34;kitchen&#34;
1067d1066
&lt;                 targetPort: 8080
1068a1068
&gt;                 targetPort: 8080
1073d1072
&lt;                 component: &#34;kitchen&#34;
1074a1074
&gt;                 component: &#34;kitchen&#34;
1089a1090,1092
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1092d1094
&lt;                         component: &#34;kitchen&#34;
1094,1096c1096
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1118d1117
&lt;                         name:  &#34;dishwasher&#34;
1135a1135
&gt;                         name: &#34;dishwasher&#34;
1159d1158
&lt;                 component: &#34;kitchen&#34;
1160a1160
&gt;                 component: &#34;kitchen&#34;
1166d1165
&lt;                 targetPort: 8080
1167a1167
&gt;                 targetPort: 8080
1172d1171
&lt;                 component: &#34;kitchen&#34;
1173a1173
&gt;                 component: &#34;kitchen&#34;
1188a1189,1191
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1191d1193
&lt;                         component: &#34;kitchen&#34;
1193,1195c1195
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1212d1211
&lt;                         name:  &#34;expiditer&#34;
1225a1225
&gt;                         name: &#34;expiditer&#34;
1249d1248
&lt;                 component: &#34;kitchen&#34;
1250a1250
&gt;                 component: &#34;kitchen&#34;
1256d1255
&lt;                 targetPort: 8080
1257a1257
&gt;                 targetPort: 8080
1262d1261
&lt;                 component: &#34;kitchen&#34;
1263a1263
&gt;                 component: &#34;kitchen&#34;
1278a1279,1281
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1281d1283
&lt;                         component: &#34;kitchen&#34;
1283,1285c1285
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1302d1301
&lt;                         name:  &#34;headchef&#34;
1315a1315
&gt;                         name: &#34;headchef&#34;
1339d1338
&lt;                 component: &#34;kitchen&#34;
1340a1340
&gt;                 component: &#34;kitchen&#34;
1346d1345
&lt;                 targetPort: 8080
1347a1347
&gt;                 targetPort: 8080
1352d1351
&lt;                 component: &#34;kitchen&#34;
1353a1353
&gt;                 component: &#34;kitchen&#34;
1368a1369,1371
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1371d1373
&lt;                         component: &#34;kitchen&#34;
1373,1375c1375
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1392d1391
&lt;                         name:  &#34;linecook&#34;
1405a1405
&gt;                         name: &#34;linecook&#34;
1429d1428
&lt;                 component: &#34;kitchen&#34;
1430a1430
&gt;                 component: &#34;kitchen&#34;
1436d1435
&lt;                 targetPort: 8080
1437a1437
&gt;                 targetPort: 8080
1442d1441
&lt;                 component: &#34;kitchen&#34;
1443a1443
&gt;                 component: &#34;kitchen&#34;
1458a1459,1461
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1461d1463
&lt;                         component: &#34;kitchen&#34;
1463,1465c1465
&lt;                     &#125;
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
---
&gt;                         component: &#34;kitchen&#34;
1482d1481
&lt;                         name:  &#34;pastrychef&#34;
1495a1495
&gt;                         name: &#34;pastrychef&#34;
1519d1518
&lt;                 component: &#34;kitchen&#34;
1520a1520
&gt;                 component: &#34;kitchen&#34;
1526d1525
&lt;                 targetPort: 8080
1527a1527
&gt;                 targetPort: 8080
1532d1531
&lt;                 component: &#34;kitchen&#34;
1533a1533
&gt;                 component: &#34;kitchen&#34;
1551d1550
&lt;                         component: &#34;kitchen&#34;
1552a1552
&gt;                         component: &#34;kitchen&#34;
1557d1556
&lt;                         name:  &#34;souschef&#34;
1561a1561
&gt;                         name: &#34;souschef&#34;
1588a1589
&gt;             name: &#34;alertmanager&#34;
1595d1595
&lt;             name: &#34;alertmanager&#34;
1598,1603d1597
&lt;             selector: &#123;
&lt;                 app:       &#34;alertmanager&#34;
&lt;                 name:      &#34;alertmanager&#34;
&lt;                 domain:    &#34;prod&#34;
&lt;                 component: &#34;mon&#34;
&lt;             &#125;
1606d1599
&lt;                 protocol:   &#34;TCP&#34;
1607a1601
&gt;                 protocol:   &#34;TCP&#34;
1609a1604,1609
&gt;             selector: &#123;
&gt;                 name:      &#34;alertmanager&#34;
&gt;                 app:       &#34;alertmanager&#34;
&gt;                 domain:    &#34;prod&#34;
&gt;                 component: &#34;mon&#34;
&gt;             &#125;
1648d1647
&lt;             replicas: 1
1653a1653
&gt;             replicas: 1
1665d1664
&lt;                         name:  &#34;alertmanager&#34;
1671a1671
&gt;                         name: &#34;alertmanager&#34;
1708,1712d1707
&lt;             selector: &#123;
&lt;                 app:       &#34;grafana&#34;
&lt;                 domain:    &#34;prod&#34;
&lt;                 component: &#34;mon&#34;
&lt;             &#125;
1715d1709
&lt;                 protocol:   &#34;TCP&#34;
1716a1711
&gt;                 protocol:   &#34;TCP&#34;
1718a1714,1718
&gt;             selector: &#123;
&gt;                 app:       &#34;grafana&#34;
&gt;                 domain:    &#34;prod&#34;
&gt;                 component: &#34;mon&#34;
&gt;             &#125;
1727d1726
&lt;             name: &#34;grafana&#34;
1731a1731
&gt;             name: &#34;grafana&#34;
1753d1752
&lt;                         name:  &#34;grafana&#34;
1776a1776
&gt;                         name: &#34;grafana&#34;
1792a1793,1796
&gt;             annotations: &#123;
&gt;                 &#34;prometheus.io/scrape&#34;: &#34;true&#34;
&gt;             &#125;
&gt;             name: &#34;node-exporter&#34;
1798,1801d1801
&lt;             annotations: &#123;
&lt;                 &#34;prometheus.io/scrape&#34;: &#34;true&#34;
&lt;             &#125;
&lt;             name: &#34;node-exporter&#34;
1891a1892
&gt;             name: &#34;prometheus&#34;
1898d1898
&lt;             name: &#34;prometheus&#34;
1901,1906d1900
&lt;             selector: &#123;
&lt;                 app:       &#34;prometheus&#34;
&lt;                 name:      &#34;prometheus&#34;
&lt;                 domain:    &#34;prod&#34;
&lt;                 component: &#34;mon&#34;
&lt;             &#125;
1910d1903
&lt;                 protocol: &#34;TCP&#34;
1911a1905
&gt;                 protocol: &#34;TCP&#34;
1913a1908,1913
&gt;             selector: &#123;
&gt;                 name:      &#34;prometheus&#34;
&gt;                 app:       &#34;prometheus&#34;
&gt;                 domain:    &#34;prod&#34;
&gt;                 component: &#34;mon&#34;
&gt;             &#125;
2163d2162
&lt;             replicas: 1
2175a2175
&gt;             replicas: 1
2190d2189
&lt;                         name:  &#34;prometheus&#34;
2196a2196
&gt;                         name: &#34;prometheus&#34;
2232d2231
&lt;                 targetPort: 4180
2233a2233
&gt;                 targetPort: 4180
2263d2262
&lt;                         name:  &#34;authproxy&#34;
2268a2268
&gt;                         name: &#34;authproxy&#34;
2404d2403
&lt;                         name:  &#34;goget&#34;
2408a2408
&gt;                         name: &#34;goget&#34;
2483d2482
&lt;                         name:  &#34;nginx&#34;
2489a2489
&gt;                         name: &#34;nginx&#34;
</code></pre>

We can do better, though.
A first thing to note is that DaemonSets and StatefulSets share a similar
structure to Deployments.
We generalize the top-level template as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="a3ViZS5jdWU=:cGFja2FnZSBrdWJlCgpzZXJ2aWNlOiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJ2MSIKCWtpbmQ6ICAgICAgICJTZXJ2aWNlIgoJbWV0YWRhdGE6IHsKCQluYW1lOiBJRAoJCWxhYmVsczogewoJCQlhcHA6ICAgICAgIElEICAgICAgICAgLy8gYnkgY29udmVudGlvbgoJCQlkb21haW46ICAgICJwcm9kIiAgICAgLy8gYWx3YXlzIHRoZSBzYW1lIGluIHRoZSBnaXZlbiBmaWxlcwoJCQljb21wb25lbnQ6ICNDb21wb25lbnQgLy8gdmFyaWVzIHBlciBkaXJlY3RvcnkKCQl9Cgl9CglzcGVjOiB7CgkJLy8gQW55IHBvcnQgaGFzIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllcy4KCQlwb3J0czogWy4uLnsKCQkJcG9ydDogICAgIGludAoJCQlwcm90b2NvbDogKiJUQ1AiIHwgIlVEUCIgLy8gZnJvbSB0aGUgS3ViZXJuZXRlcyBkZWZpbml0aW9uCgkJCW5hbWU6ICAgICBzdHJpbmcgfCAqImNsaWVudCIKCQl9XQoJCXNlbGVjdG9yOiBtZXRhZGF0YS5sYWJlbHMgLy8gd2Ugd2FudCB0aG9zZSB0byBiZSB0aGUgc2FtZQoJfQp9CgpkZXBsb3ltZW50OiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCgltZXRhZGF0YTogbmFtZTogSUQKCXNwZWM6IHsKCQkvLyAxIGlzIHRoZSBkZWZhdWx0LCBidXQgd2UgYWxsb3cgYW55IG51bWJlcgoJCXJlcGxpY2FzOiAqMSB8IGludAoJCXRlbXBsYXRlOiB7CgkJCW1ldGFkYXRhOiBsYWJlbHM6IHsKCQkJCWFwcDogICAgICAgSUQKCQkJCWRvbWFpbjogICAgInByb2QiCgkJCQljb21wb25lbnQ6ICNDb21wb25lbnQKCQkJfQoJCQkvLyB3ZSBhbHdheXMgaGF2ZSBvbmUgbmFtZXNha2UgY29udGFpbmVyCgkJCXNwZWM6IGNvbnRhaW5lcnM6IFt7bmFtZTogSUR9XQoJCX0KCX0KfQoKI0NvbXBvbmVudDogc3RyaW5nCgpkYWVtb25TZXQ6IFtJRD1fXTogX3NwZWMgJiB7CglhcGlWZXJzaW9uOiAiYXBwcy92MSIKCWtpbmQ6ICAgICAgICJEYWVtb25TZXQiCglfbmFtZTogICAgICBJRAp9CgpzdGF0ZWZ1bFNldDogW0lEPV9dOiBfc3BlYyAmIHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIlN0YXRlZnVsU2V0IgoJX25hbWU6ICAgICAgSUQKfQoKZGVwbG95bWVudDogW0lEPV9dOiBfc3BlYyAmIHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCglfbmFtZTogICAgICBJRAoJc3BlYzogcmVwbGljYXM6ICoxIHwgaW50Cn0KCmNvbmZpZ01hcDogW0lEPV9dOiB7CgltZXRhZGF0YTogbmFtZTogSUQKCW1ldGFkYXRhOiBsYWJlbHM6IGNvbXBvbmVudDogI0NvbXBvbmVudAp9Cgpfc3BlYzogewoJX25hbWU6IHN0cmluZwoKCW1ldGFkYXRhOiBuYW1lOiBfbmFtZQoJbWV0YWRhdGE6IGxhYmVsczogY29tcG9uZW50OiAjQ29tcG9uZW50CglzcGVjOiBzZWxlY3Rvcjoge30KCXNwZWM6IHRlbXBsYXRlOiB7CgkJbWV0YWRhdGE6IGxhYmVsczogewoJCQlhcHA6ICAgICAgIF9uYW1lCgkJCWNvbXBvbmVudDogI0NvbXBvbmVudAoJCQlkb21haW46ICAgICJwcm9kIgoJCX0KCQlzcGVjOiBjb250YWluZXJzOiBbe25hbWU6IF9uYW1lfV0KCX0KfQo=" data-upload-term=".term1"><code class="language-cue">package kube

service: [ID=_]: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;Service&#34;
	metadata: &#123;
		name: ID
		labels: &#123;
			app:       ID         // by convention
			domain:    &#34;prod&#34;     // always the same in the given files
			component: #Component // varies per directory
		&#125;
	&#125;
	spec: &#123;
		// Any port has the following properties.
		ports: [...&#123;
			port:     int
			protocol: *&#34;TCP&#34; | &#34;UDP&#34; // from the Kubernetes definition
			name:     string | *&#34;client&#34;
		&#125;]
		selector: metadata.labels // we want those to be the same
	&#125;
&#125;

deployment: [ID=_]: &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;Deployment&#34;
	metadata: name: ID
	spec: &#123;
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: &#123;
			metadata: labels: &#123;
				app:       ID
				domain:    &#34;prod&#34;
				component: #Component
			&#125;
			// we always have one namesake container
			spec: containers: [&#123;name: ID&#125;]
		&#125;
	&#125;
&#125;

#Component: string
<b></b>
<b>daemonSet: [ID=_]: _spec &amp; &#123;</b>
<b>	apiVersion: &#34;apps/v1&#34;</b>
<b>	kind:       &#34;DaemonSet&#34;</b>
<b>	_name:      ID</b>
<b>&#125;</b>
<b></b>
<b>statefulSet: [ID=_]: _spec &amp; &#123;</b>
<b>	apiVersion: &#34;apps/v1&#34;</b>
<b>	kind:       &#34;StatefulSet&#34;</b>
<b>	_name:      ID</b>
<b>&#125;</b>
<b></b>
<b>deployment: [ID=_]: _spec &amp; &#123;</b>
<b>	apiVersion: &#34;apps/v1&#34;</b>
<b>	kind:       &#34;Deployment&#34;</b>
<b>	_name:      ID</b>
<b>	spec: replicas: *1 | int</b>
<b>&#125;</b>
<b></b>
<b>configMap: [ID=_]: &#123;</b>
<b>	metadata: name: ID</b>
<b>	metadata: labels: component: #Component</b>
<b>&#125;</b>
<b></b>
<b>_spec: &#123;</b>
<b>	_name: string</b>
<b></b>
<b>	metadata: name: _name</b>
<b>	metadata: labels: component: #Component</b>
<b>	spec: selector: &#123;&#125;</b>
<b>	spec: template: &#123;</b>
<b>		metadata: labels: &#123;</b>
<b>			app:       _name</b>
<b>			component: #Component</b>
<b>			domain:    &#34;prod&#34;</b>
<b>		&#125;</b>
<b>		spec: containers: [&#123;name: _name&#125;]</b>
<b>	&#125;</b>
<b>&#125;</b>
</code></pre>

The common configuration has been factored out into `_spec`.
We introduced `_name` to aid both specifying and referring
to the name of an object.
For completeness, we added `configMap` as a top-level entry.

Note that we have not yet removed the old definition of deployment.
This is fine.
As it is equivalent to the new one, unifying them will have no effect.
We leave its removal as an exercise to the reader.

Next we observe that all deployments, stateful sets and daemon sets have
an accompanying service which shares many of the same fields.
We add:

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="a3ViZS5jdWU=:cGFja2FnZSBrdWJlCgpzZXJ2aWNlOiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJ2MSIKCWtpbmQ6ICAgICAgICJTZXJ2aWNlIgoJbWV0YWRhdGE6IHsKCQluYW1lOiBJRAoJCWxhYmVsczogewoJCQlhcHA6ICAgICAgIElEICAgICAgICAgLy8gYnkgY29udmVudGlvbgoJCQlkb21haW46ICAgICJwcm9kIiAgICAgLy8gYWx3YXlzIHRoZSBzYW1lIGluIHRoZSBnaXZlbiBmaWxlcwoJCQljb21wb25lbnQ6ICNDb21wb25lbnQgLy8gdmFyaWVzIHBlciBkaXJlY3RvcnkKCQl9Cgl9CglzcGVjOiB7CgkJLy8gQW55IHBvcnQgaGFzIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllcy4KCQlwb3J0czogWy4uLnsKCQkJcG9ydDogICAgIGludAoJCQlwcm90b2NvbDogKiJUQ1AiIHwgIlVEUCIgLy8gZnJvbSB0aGUgS3ViZXJuZXRlcyBkZWZpbml0aW9uCgkJCW5hbWU6ICAgICBzdHJpbmcgfCAqImNsaWVudCIKCQl9XQoJCXNlbGVjdG9yOiBtZXRhZGF0YS5sYWJlbHMgLy8gd2Ugd2FudCB0aG9zZSB0byBiZSB0aGUgc2FtZQoJfQp9CgpkZXBsb3ltZW50OiBbSUQ9X106IHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCgltZXRhZGF0YTogbmFtZTogSUQKCXNwZWM6IHsKCQkvLyAxIGlzIHRoZSBkZWZhdWx0LCBidXQgd2UgYWxsb3cgYW55IG51bWJlcgoJCXJlcGxpY2FzOiAqMSB8IGludAoJCXRlbXBsYXRlOiB7CgkJCW1ldGFkYXRhOiBsYWJlbHM6IHsKCQkJCWFwcDogICAgICAgSUQKCQkJCWRvbWFpbjogICAgInByb2QiCgkJCQljb21wb25lbnQ6ICNDb21wb25lbnQKCQkJfQoJCQkvLyB3ZSBhbHdheXMgaGF2ZSBvbmUgbmFtZXNha2UgY29udGFpbmVyCgkJCXNwZWM6IGNvbnRhaW5lcnM6IFt7bmFtZTogSUR9XQoJCX0KCX0KfQoKI0NvbXBvbmVudDogc3RyaW5nCgpkYWVtb25TZXQ6IFtJRD1fXTogX3NwZWMgJiB7CglhcGlWZXJzaW9uOiAiYXBwcy92MSIKCWtpbmQ6ICAgICAgICJEYWVtb25TZXQiCglfbmFtZTogICAgICBJRAp9CgpzdGF0ZWZ1bFNldDogW0lEPV9dOiBfc3BlYyAmIHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIlN0YXRlZnVsU2V0IgoJX25hbWU6ICAgICAgSUQKfQoKZGVwbG95bWVudDogW0lEPV9dOiBfc3BlYyAmIHsKCWFwaVZlcnNpb246ICJhcHBzL3YxIgoJa2luZDogICAgICAgIkRlcGxveW1lbnQiCglfbmFtZTogICAgICBJRAoJc3BlYzogcmVwbGljYXM6ICoxIHwgaW50Cn0KCmNvbmZpZ01hcDogW0lEPV9dOiB7CgltZXRhZGF0YTogbmFtZTogSUQKCW1ldGFkYXRhOiBsYWJlbHM6IGNvbXBvbmVudDogI0NvbXBvbmVudAp9Cgpfc3BlYzogewoJX25hbWU6IHN0cmluZwoKCW1ldGFkYXRhOiBuYW1lOiBfbmFtZQoJbWV0YWRhdGE6IGxhYmVsczogY29tcG9uZW50OiAjQ29tcG9uZW50CglzcGVjOiBzZWxlY3Rvcjoge30KCXNwZWM6IHRlbXBsYXRlOiB7CgkJbWV0YWRhdGE6IGxhYmVsczogewoJCQlhcHA6ICAgICAgIF9uYW1lCgkJCWNvbXBvbmVudDogI0NvbXBvbmVudAoJCQlkb21haW46ICAgICJwcm9kIgoJCX0KCQlzcGVjOiBjb250YWluZXJzOiBbe25hbWU6IF9uYW1lfV0KCX0KfQoKLy8gRGVmaW5lIHRoZSBfZXhwb3J0IG9wdGlvbiBhbmQgc2V0IHRoZSBkZWZhdWx0IHRvIHRydWUKLy8gZm9yIGFsbCBwb3J0cyBkZWZpbmVkIGluIGFsbCBjb250YWluZXJzLgpfc3BlYzogc3BlYzogdGVtcGxhdGU6IHNwZWM6IGNvbnRhaW5lcnM6IFsuLi57Cglwb3J0czogWy4uLnsKCQlfZXhwb3J0OiAqdHJ1ZSB8IGZhbHNlIC8vIGluY2x1ZGUgdGhlIHBvcnQgaW4gdGhlIHNlcnZpY2UKCX1dCn1dCgpmb3IgeCBpbiBbZGVwbG95bWVudCwgZGFlbW9uU2V0LCBzdGF0ZWZ1bFNldF0gZm9yIGssIHYgaW4geCB7CglzZXJ2aWNlOiAiXChrKSI6IHsKCQlzcGVjOiBzZWxlY3Rvcjogdi5zcGVjLnRlbXBsYXRlLm1ldGFkYXRhLmxhYmVscwoKCQlzcGVjOiBwb3J0czogWwoJCQlmb3IgYyBpbiB2LnNwZWMudGVtcGxhdGUuc3BlYy5jb250YWluZXJzCgkJCWZvciBwIGluIGMucG9ydHMKCQkJaWYgcC5fZXhwb3J0IHsKCQkJCWxldCBQb3J0ID0gcC5jb250YWluZXJQb3J0IC8vIFBvcnQgaXMgYW4gYWxpYXMKCQkJCXBvcnQ6ICAgICAgICpQb3J0IHwgaW50CgkJCQl0YXJnZXRQb3J0OiAqUG9ydCB8IGludAoJCQl9LAoJCV0KCX0KfQo=" data-upload-term=".term1"><code class="language-cue">package kube

service: [ID=_]: &#123;
	apiVersion: &#34;v1&#34;
	kind:       &#34;Service&#34;
	metadata: &#123;
		name: ID
		labels: &#123;
			app:       ID         // by convention
			domain:    &#34;prod&#34;     // always the same in the given files
			component: #Component // varies per directory
		&#125;
	&#125;
	spec: &#123;
		// Any port has the following properties.
		ports: [...&#123;
			port:     int
			protocol: *&#34;TCP&#34; | &#34;UDP&#34; // from the Kubernetes definition
			name:     string | *&#34;client&#34;
		&#125;]
		selector: metadata.labels // we want those to be the same
	&#125;
&#125;

deployment: [ID=_]: &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;Deployment&#34;
	metadata: name: ID
	spec: &#123;
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: &#123;
			metadata: labels: &#123;
				app:       ID
				domain:    &#34;prod&#34;
				component: #Component
			&#125;
			// we always have one namesake container
			spec: containers: [&#123;name: ID&#125;]
		&#125;
	&#125;
&#125;

#Component: string

daemonSet: [ID=_]: _spec &amp; &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;DaemonSet&#34;
	_name:      ID
&#125;

statefulSet: [ID=_]: _spec &amp; &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;StatefulSet&#34;
	_name:      ID
&#125;

deployment: [ID=_]: _spec &amp; &#123;
	apiVersion: &#34;apps/v1&#34;
	kind:       &#34;Deployment&#34;
	_name:      ID
	spec: replicas: *1 | int
&#125;

configMap: [ID=_]: &#123;
	metadata: name: ID
	metadata: labels: component: #Component
&#125;

_spec: &#123;
	_name: string

	metadata: name: _name
	metadata: labels: component: #Component
	spec: selector: &#123;&#125;
	spec: template: &#123;
		metadata: labels: &#123;
			app:       _name
			component: #Component
			domain:    &#34;prod&#34;
		&#125;
		spec: containers: [&#123;name: _name&#125;]
	&#125;
&#125;
<b></b>
<b>// Define the _export option and set the default to true</b>
<b>// for all ports defined in all containers.</b>
<b>_spec: spec: template: spec: containers: [...&#123;</b>
<b>	ports: [...&#123;</b>
<b>		_export: *true | false // include the port in the service</b>
<b>	&#125;]</b>
<b>&#125;]</b>
<b></b>
<b>for x in [deployment, daemonSet, statefulSet] for k, v in x &#123;</b>
<b>	service: &#34;\(k)&#34;: &#123;</b>
<b>		spec: selector: v.spec.template.metadata.labels</b>
<b></b>
<b>		spec: ports: [</b>
<b>			for c in v.spec.template.spec.containers</b>
<b>			for p in c.ports</b>
<b>			if p._export &#123;</b>
<b>				let Port = p.containerPort // Port is an alias</b>
<b>				port:       *Port | int</b>
<b>				targetPort: *Port | int</b>
<b>			&#125;,</b>
<b>		]</b>
<b>	&#125;</b>
<b>&#125;</b>
</code></pre>

This example introduces a few new concepts.
Open-ended lists are indicated with an ellipsis (`...`).
The value following an ellipsis is unified with any subsequent elements and
defines the "type", or template, for additional list elements.

The `Port` declaration is an alias.
Aliases are only visible in their lexical scope and are not part of the model.
They can be used to make shadowed fields visible within nested scopes or,
in this case, to reduce boilerplate without introducing new fields.

Finally, this example introduces list and field comprehensions.
List comprehensions are analogous to list comprehensions found in other
languages.
Field comprehensions allow inserting fields in structs.
In this case, the field comprehension adds a namesake service for any
deployment, daemonSet, and statefulSet.
Field comprehensions can also be used to add a field conditionally.


Specifying the `targetPort` is not necessary, but since many files define it,
defining it here will allow those definitions to be removed
using `cue trim`.
We add an option `_export` for ports defined in containers to specify whether
to include them in the service and explicitly set this to false
for the respective ports in `infra/events`, `infra/tasks`, and `infra/watcher`.

For the purpose of this tutorial, here are some quick patches:

<pre data-command-src="Y2F0IDw8RU9GID4+aW5mcmEvZXZlbnRzL2t1YmUuY3VlCgpkZXBsb3ltZW50OiBldmVudHM6IHNwZWM6IHRlbXBsYXRlOiBzcGVjOiBjb250YWluZXJzOiBbeyBwb3J0czogW3tfZXhwb3J0OiBmYWxzZX0sIF9dIH1dCkVPRgpjYXQgPDxFT0YgPj5pbmZyYS90YXNrcy9rdWJlLmN1ZQoKZGVwbG95bWVudDogdGFza3M6IHNwZWM6IHRlbXBsYXRlOiBzcGVjOiBjb250YWluZXJzOiBbeyBwb3J0czogW3tfZXhwb3J0OiBmYWxzZX0sIF9dIH1dCkVPRgpjYXQgPDxFT0YgPj5pbmZyYS93YXRjaGVyL2t1YmUuY3VlCgpkZXBsb3ltZW50OiB3YXRjaGVyOiBzcGVjOiB0ZW1wbGF0ZTogc3BlYzogY29udGFpbmVyczogW3sgcG9ydHM6IFt7X2V4cG9ydDogZmFsc2V9LCBfXSB9XQpFT0YK"><code class="language-.term1">$ cat &lt;&lt;EOF &gt;&gt;infra/events/kube.cue

deployment: events: spec: template: spec: containers: [&#123; ports: [&#123;_export: false&#125;, _] &#125;]
EOF
$ cat &lt;&lt;EOF &gt;&gt;infra/tasks/kube.cue

deployment: tasks: spec: template: spec: containers: [&#123; ports: [&#123;_export: false&#125;, _] &#125;]
EOF
$ cat &lt;&lt;EOF &gt;&gt;infra/watcher/kube.cue

deployment: watcher: spec: template: spec: containers: [&#123; ports: [&#123;_export: false&#125;, _] &#125;]
EOF
</code></pre>

In practice it would be more proper form to add this field in the original
port declaration.

We verify that all changes are acceptable and store another snapshot.
Then we run trim to further reduce our configuration:

<pre data-command-src="Y3VlIHRyaW0gLi8uLi4KZmluZCAuIHwgZ3JlcCBrdWJlLmN1ZSB8IHhhcmdzIHdjIHwgdGFpbCAtMQo="><code class="language-.term1">$ cue trim ./...
$ find . | grep kube.cue | xargs wc | tail -1
 1252  2366 23155 total
</code></pre>

This is after removing the rewritten and now redundant deployment definition.

We shaved off almost another 100 lines, even after adding the template.
You can verify that the service definitions are now gone in most of the files.
What remains is either some additional configuration, or inconsistencies that
should probably be cleaned up.

But we have another trick up our sleeve.
With the `-s` or `--simplify` option we can tell `trim` or `fmt` to collapse
structs with a single element onto a single line. For instance:

<pre data-command-src="aGVhZCBmcm9udGVuZC9icmVhZGRpc3BhdGNoZXIva3ViZS5jdWUKY3VlIHRyaW0gLi8uLi4gLXMKaGVhZCAtNyBmcm9udGVuZC9icmVhZGRpc3BhdGNoZXIva3ViZS5jdWUKZmluZCAuIHwgZ3JlcCBrdWJlLmN1ZSB8IHhhcmdzIHdjIHwgdGFpbCAtMQo="><code class="language-.term1">$ head frontend/breaddispatcher/kube.cue
package kube

deployment: breaddispatcher: &#123;
	spec: &#123;
		template: &#123;
			metadata: &#123;
				annotations: &#123;
					&#34;prometheus.io.scrape&#34;: &#34;true&#34;
					&#34;prometheus.io.port&#34;:   &#34;7080&#34;
				&#125;
$ cue trim ./... -s
$ head -7 frontend/breaddispatcher/kube.cue
package kube

deployment: breaddispatcher: spec: template: &#123;
	metadata: annotations: &#123;
		&#34;prometheus.io.scrape&#34;: &#34;true&#34;
		&#34;prometheus.io.port&#34;:   &#34;7080&#34;
	&#125;
$ find . | grep kube.cue | xargs wc | tail -1
 1106  2220 21391 total
</code></pre>

Another 150 lines lost!
Collapsing lines like this can improve the readability of a configuration
by removing considerable amounts of punctuation.


### Repeat for several subdirectories

In the previous section we defined templates for services and deployments
in the root of our directory structure to capture the common traits of all
services and deployments.
In addition, we defined a directory-specific label.
In this section we will look into generalizing the objects per directory.


#### Directory `frontend`

We observe that all deployments in subdirectories of `frontend`
have a single container with one port,
which is usually `7080`, but sometimes `8080`.
Also, most have two prometheus-related annotations, while some have one.
We leave the inconsistencies in ports, but add both annotations
unconditionally.

<pre data-command-src="Y2F0IDw8RU9GID4+ZnJvbnRlbmQva3ViZS5jdWUKCmRlcGxveW1lbnQ6IFtzdHJpbmddOiBzcGVjOiB0ZW1wbGF0ZTogewoJbWV0YWRhdGE6IGFubm90YXRpb25zOiB7CgkJInByb21ldGhldXMuaW8uc2NyYXBlIjogInRydWUiCgkJInByb21ldGhldXMuaW8ucG9ydCI6ICAgIlwoc3BlYy5jb250YWluZXJzWzBdLnBvcnRzWzBdLmNvbnRhaW5lclBvcnQpIgoJfQoJc3BlYzogY29udGFpbmVyczogW3sKCQlwb3J0czogW3tjb250YWluZXJQb3J0OiAqNzA4MCB8IGludH1dIC8vIDcwODAgaXMgdGhlIGRlZmF1bHQKCX1dCn0KRU9GCmN1ZSBmbXQgLi9mcm9udGVuZAo="><code class="language-.term1">$ cat &lt;&lt;EOF &gt;&gt;frontend/kube.cue

deployment: [string]: spec: template: &#123;
	metadata: annotations: &#123;
		&#34;prometheus.io.scrape&#34;: &#34;true&#34;
		&#34;prometheus.io.port&#34;:   &#34;\(spec.containers[0].ports[0].containerPort)&#34;
	&#125;
	spec: containers: [&#123;
		ports: [&#123;containerPort: *7080 | int&#125;] // 7080 is the default
	&#125;]
&#125;
EOF
$ cue fmt ./frontend
</code></pre>

Check differences:

<pre data-command-src="Y3VlIGV2YWwgLWMgLi8uLi4gPnNuYXBzaG90MgpkaWZmIC13dSBzbmFwc2hvdCBzbmFwc2hvdDIKY3Agc25hcHNob3QyIHNuYXBzaG90Cg=="><code class="language-.term1">$ cue eval -c ./... &gt;snapshot2
$ diff -wu snapshot snapshot2
--- snapshot	2021-03-11 11:19:41.303413877 +0000
+++ snapshot2	2021-03-11 11:19:56.462787306 +0000
@@ -1,8 +1,14 @@
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     bartender: &#123;
@@ -11,22 +17,22 @@
         metadata: &#123;
             name: &#34;bartender&#34;
             labels: &#123;
-                component: &#34;frontend&#34;
                 app:       &#34;bartender&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
-                component: &#34;frontend&#34;
                 app:       &#34;bartender&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -35,37 +41,44 @@
     bartender: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;bartender&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        component: &#34;frontend&#34;
-                        app:       &#34;bartender&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;bartender&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;frontend&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;bartender&#34;
                         image: &#34;gcr.io/myproj/bartender:v0.1.34&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
+                        name: &#34;bartender&#34;
                         args: []
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;bartender&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     breaddispatcher: &#123;
@@ -75,21 +88,21 @@
             name: &#34;breaddispatcher&#34;
             labels: &#123;
                 app:       &#34;breaddispatcher&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;breaddispatcher&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -98,37 +111,44 @@
     breaddispatcher: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;breaddispatcher&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;breaddispatcher&#34;
-                        component: &#34;frontend&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;breaddispatcher&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;frontend&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;breaddispatcher&#34;
                         image: &#34;gcr.io/myproj/breaddispatcher:v0.3.24&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
+                        name: &#34;breaddispatcher&#34;
                         args: [&#34;-etcd=etcd:2379&#34;, &#34;-event-server=events:7788&#34;]
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;breaddispatcher&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     host: &#123;
@@ -138,21 +158,21 @@
             name: &#34;host&#34;
             labels: &#123;
                 app:       &#34;host&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;host&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -161,36 +181,44 @@
     host: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;host&#34;
-        &#125;
         spec: &#123;
             replicas: 2
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        &#34;prometheus.io.port&#34;:   &#34;7080&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;host&#34;
-                        component: &#34;frontend&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;frontend&#34;
                     &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;host&#34;
                         image: &#34;gcr.io/myproj/host:v0.1.10&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
+                        name: &#34;host&#34;
                         args: []
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;host&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     maitred: &#123;
@@ -200,15 +228,15 @@
             name: &#34;maitred&#34;
             labels: &#123;
                 app:       &#34;maitred&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
@@ -223,37 +251,44 @@
     maitred: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;maitred&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;maitred&#34;
-                        component: &#34;frontend&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;maitred&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;frontend&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;maitred&#34;
                         image: &#34;gcr.io/myproj/maitred:v0.0.4&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
+                        name: &#34;maitred&#34;
                         args: []
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;maitred&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     valeter: &#123;
@@ -262,17 +297,17 @@
         metadata: &#123;
             name: &#34;valeter&#34;
             labels: &#123;
-                component: &#34;frontend&#34;
                 app:       &#34;valeter&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
                 name:       &#34;http&#34;
+                targetPort: 8080
             &#125;]
             selector: &#123;
                 app:       &#34;valeter&#34;
@@ -286,36 +321,44 @@
     valeter: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;valeter&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        &#34;prometheus.io.port&#34;:   &#34;8080&#34;
+                    &#125;
                     labels: &#123;
-                        component: &#34;frontend&#34;
                         app:       &#34;valeter&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;frontend&#34;
                     &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;valeter&#34;
                         image: &#34;gcr.io/myproj/valeter:v0.0.4&#34;
                         ports: [&#123;
                             containerPort: 8080
                         &#125;]
+                        name: &#34;valeter&#34;
                         args: [&#34;-http=:8080&#34;, &#34;-etcd=etcd:2379&#34;]
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;valeter&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     waiter: &#123;
@@ -324,22 +367,22 @@
         metadata: &#123;
             name: &#34;waiter&#34;
             labels: &#123;
-                component: &#34;frontend&#34;
                 app:       &#34;waiter&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;waiter&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -348,27 +391,25 @@
     waiter: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;waiter&#34;
-        &#125;
         spec: &#123;
             replicas: 5
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        component: &#34;frontend&#34;
-                        app:       &#34;waiter&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;waiter&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;frontend&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;waiter&#34;
                         image: &#34;gcr.io/myproj/waiter:v0.3.0&#34;
+                        name:  &#34;waiter&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
@@ -376,8 +417,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;waiter&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     waterdispatcher: &#123;
@@ -387,21 +437,21 @@
             name: &#34;waterdispatcher&#34;
             labels: &#123;
                 app:       &#34;waterdispatcher&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
                 name:       &#34;http&#34;
+                targetPort: 7080
             &#125;]
             selector: &#123;
                 app:       &#34;waterdispatcher&#34;
-                component: &#34;frontend&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;frontend&#34;
             &#125;
         &#125;
     &#125;
@@ -410,40 +460,50 @@
     waterdispatcher: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;waterdispatcher&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;waterdispatcher&#34;
-                        component: &#34;frontend&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;waterdispatcher&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;frontend&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;waterdispatcher&#34;
                         image: &#34;gcr.io/myproj/waterdispatcher:v0.0.48&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
+                        name: &#34;waterdispatcher&#34;
                         args: [&#34;-http=:8080&#34;, &#34;-etcd=etcd:2379&#34;]
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;waterdispatcher&#34;
+            labels: &#123;
+                component: &#34;frontend&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     download: &#123;
@@ -453,15 +513,15 @@
             name: &#34;download&#34;
             labels: &#123;
                 app:       &#34;download&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7080
-                targetPort: 7080
                 protocol:   &#34;TCP&#34;
+                targetPort: 7080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
@@ -476,23 +536,21 @@
     download: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;download&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;download&#34;
-                        component: &#34;infra&#34;
                         domain:    &#34;prod&#34;
+                        component: &#34;infra&#34;
                     &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;download&#34;
                         image: &#34;gcr.io/myproj/download:v0.0.2&#34;
+                        name:  &#34;download&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;]
@@ -500,8 +558,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;download&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     etcd: &#123;
@@ -517,46 +584,45 @@
         &#125;
         spec: &#123;
             clusterIP: &#34;None&#34;
-            selector: &#123;
-                app:       &#34;etcd&#34;
-                domain:    &#34;prod&#34;
-                component: &#34;infra&#34;
-            &#125;
             ports: [&#123;
                 port:       2379
-                targetPort: 2379
                 protocol:   &#34;TCP&#34;
+                targetPort: 2379
                 name:       &#34;client&#34;
             &#125;, &#123;
                 port:       2380
-                targetPort: 2380
                 protocol:   &#34;TCP&#34;
                 name:       &#34;peer&#34;
+                targetPort: 2380
             &#125;]
+            selector: &#123;
+                app:       &#34;etcd&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
+            &#125;
         &#125;
     &#125;
 &#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
 statefulSet: &#123;
     etcd: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;StatefulSet&#34;
-        metadata: &#123;
-            name: &#34;etcd&#34;
-        &#125;
         spec: &#123;
             serviceName: &#34;etcd&#34;
             replicas:    3
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;etcd&#34;
-                        component: &#34;infra&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;2379&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;etcd&#34;
+                        component: &#34;infra&#34;
+                        domain:    &#34;prod&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     affinity: &#123;
@@ -575,7 +641,6 @@
                     &#125;
                     terminationGracePeriodSeconds: 10
                     containers: [&#123;
-                        name:  &#34;etcd&#34;
                         image: &#34;quay.io/coreos/etcd:v3.3.10&#34;
                         ports: [&#123;
                             name:          &#34;client&#34;
@@ -617,10 +682,12 @@
                             &#125;
                         &#125;]
                         command: [&#34;/usr/local/bin/etcd&#34;]
+                        name: &#34;etcd&#34;
                         args: [&#34;-name&#34;, &#34;$(NAME)&#34;, &#34;-data-dir&#34;, &#34;/data/etcd3&#34;, &#34;-initial-advertise-peer-urls&#34;, &#34;http://$(IP):2380&#34;, &#34;-listen-peer-urls&#34;, &#34;http://$(IP):2380&#34;, &#34;-listen-client-urls&#34;, &#34;http://$(IP):2379,http://127.0.0.1:2379&#34;, &#34;-advertise-client-urls&#34;, &#34;http://$(IP):2379&#34;, &#34;-discovery&#34;, &#34;https://discovery.etcd.io/xxxxxx&#34;]
                     &#125;]
                 &#125;
             &#125;
+            selector: &#123;&#125;
             volumeClaimTemplates: [&#123;
                 metadata: &#123;
                     name: &#34;etcd3&#34;
@@ -638,8 +705,15 @@
                 &#125;
             &#125;]
         &#125;
+        metadata: &#123;
+            name: &#34;etcd&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     events: &#123;
@@ -649,21 +723,21 @@
             name: &#34;events&#34;
             labels: &#123;
                 app:       &#34;events&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       7788
-                targetPort: 7788
                 protocol:   &#34;TCP&#34;
                 name:       &#34;grpc&#34;
+                targetPort: 7788
             &#125;]
             selector: &#123;
                 app:       &#34;events&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
     &#125;
@@ -672,22 +746,20 @@
     events: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;events&#34;
-        &#125;
         spec: &#123;
             replicas: 2
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
-                    labels: &#123;
-                        app:       &#34;events&#34;
-                        component: &#34;infra&#34;
-                        domain:    &#34;prod&#34;
-                    &#125;
                     annotations: &#123;
                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
                     &#125;
+                    labels: &#123;
+                        app:       &#34;events&#34;
+                        domain:    &#34;prod&#34;
+                        component: &#34;infra&#34;
+                    &#125;
                 &#125;
                 spec: &#123;
                     affinity: &#123;
@@ -711,7 +783,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;events&#34;
                         image: &#34;gcr.io/myproj/events:v0.1.31&#34;
                         ports: [&#123;
                             containerPort: 7080
@@ -719,6 +790,7 @@
                             containerPort: 7788
                         &#125;]
                         args: [&#34;-cert=/etc/ssl/server.pem&#34;, &#34;-key=/etc/ssl/server.key&#34;, &#34;-grpc=:7788&#34;]
+                        name: &#34;events&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/ssl&#34;
                             name:      &#34;secret-volume&#34;
@@ -727,8 +799,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;events&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     tasks: &#123;
@@ -747,9 +828,9 @@
             loadBalancerIP: &#34;1.2.3.4&#34;
             ports: [&#123;
                 port:       443
-                targetPort: 7443
                 protocol:   &#34;TCP&#34;
                 name:       &#34;http&#34;
+                targetPort: 7443
             &#125;]
             selector: &#123;
                 app:       &#34;tasks&#34;
@@ -763,22 +844,20 @@
     tasks: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;tasks&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        &#34;prometheus.io.port&#34;:   &#34;7080&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;tasks&#34;
                         domain:    &#34;prod&#34;
                         component: &#34;infra&#34;
                     &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
-                        &#34;prometheus.io.port&#34;:   &#34;7080&#34;
-                    &#125;
                 &#125;
                 spec: &#123;
                     volumes: [&#123;
@@ -788,13 +867,13 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;tasks&#34;
                         image: &#34;gcr.io/myproj/tasks:v0.2.6&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;, &#123;
                             containerPort: 7443
                         &#125;]
+                        name: &#34;tasks&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/ssl&#34;
                             name:      &#34;secret-volume&#34;
@@ -803,8 +882,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;tasks&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     updater: &#123;
@@ -814,15 +902,15 @@
             name: &#34;updater&#34;
             labels: &#123;
                 app:       &#34;updater&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
@@ -837,17 +925,15 @@
     updater: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;updater&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;updater&#34;
-                        component: &#34;infra&#34;
                         domain:    &#34;prod&#34;
+                        component: &#34;infra&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -858,7 +944,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;updater&#34;
                         image: &#34;gcr.io/myproj/updater:v0.1.0&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/certs&#34;
@@ -867,13 +952,23 @@
                         ports: [&#123;
                             containerPort: 8080
                         &#125;]
+                        name: &#34;updater&#34;
                         args: [&#34;-key=/etc/certs/updater.pem&#34;]
                     &#125;]
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;updater&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     watcher: &#123;
@@ -883,8 +978,8 @@
             name: &#34;watcher&#34;
             labels: &#123;
                 app:       &#34;watcher&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
         spec: &#123;
@@ -892,14 +987,14 @@
             loadBalancerIP: &#34;1.2.3.4.&#34;
             ports: [&#123;
                 port:       7788
-                targetPort: 7788
                 protocol:   &#34;TCP&#34;
                 name:       &#34;http&#34;
+                targetPort: 7788
             &#125;]
             selector: &#123;
                 app:       &#34;watcher&#34;
-                component: &#34;infra&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;infra&#34;
             &#125;
         &#125;
     &#125;
@@ -908,17 +1003,15 @@
     watcher: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;watcher&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;watcher&#34;
-                        component: &#34;infra&#34;
                         domain:    &#34;prod&#34;
+                        component: &#34;infra&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -929,13 +1022,13 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;watcher&#34;
                         image: &#34;gcr.io/myproj/watcher:v0.1.0&#34;
                         ports: [&#123;
                             containerPort: 7080
                         &#125;, &#123;
                             containerPort: 7788
                         &#125;]
+                        name: &#34;watcher&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/ssl&#34;
                             name:      &#34;secret-volume&#34;
@@ -944,11 +1037,23 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;watcher&#34;
+            labels: &#123;
+                component: &#34;infra&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     caller: &#123;
@@ -958,15 +1063,15 @@
             name: &#34;caller&#34;
             labels: &#123;
                 app:       &#34;caller&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
@@ -981,20 +1086,18 @@
     caller: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;caller&#34;
-        &#125;
         spec: &#123;
             replicas: 3
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;caller&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1016,7 +1119,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;caller&#34;
                         image: &#34;gcr.io/myproj/caller:v0.20.14&#34;
                         volumeMounts: [&#123;
                             name:      &#34;ssd-caller&#34;
@@ -1034,6 +1136,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-env=prod&#34;, &#34;-key=/etc/certs/client.key&#34;, &#34;-cert=/etc/certs/client.pem&#34;, &#34;-ca=/etc/certs/servfx.ca&#34;, &#34;-ssh-tunnel-key=/sslcerts/tunnel-private.pem&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;]
+                        name: &#34;caller&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1046,8 +1149,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;caller&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     dishwasher: &#123;
@@ -1057,21 +1169,21 @@
             name: &#34;dishwasher&#34;
             labels: &#123;
                 app:       &#34;dishwasher&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;dishwasher&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1080,20 +1192,18 @@
     dishwasher: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;dishwasher&#34;
-        &#125;
         spec: &#123;
             replicas: 5
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;dishwasher&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1115,7 +1225,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;dishwasher&#34;
                         image: &#34;gcr.io/myproj/dishwasher:v0.2.13&#34;
                         volumeMounts: [&#123;
                             name:      &#34;dishwasher-disk&#34;
@@ -1133,6 +1242,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-env=prod&#34;, &#34;-ssh-tunnel-key=/etc/certs/tunnel-private.pem&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;]
+                        name: &#34;dishwasher&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1145,8 +1255,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;dishwasher&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     expiditer: &#123;
@@ -1156,21 +1275,21 @@
             name: &#34;expiditer&#34;
             labels: &#123;
                 app:       &#34;expiditer&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;expiditer&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1179,20 +1298,18 @@
     expiditer: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;expiditer&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;expiditer&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1209,7 +1326,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;expiditer&#34;
                         image: &#34;gcr.io/myproj/expiditer:v0.5.34&#34;
                         volumeMounts: [&#123;
                             name:      &#34;expiditer-disk&#34;
@@ -1223,6 +1339,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-env=prod&#34;, &#34;-ssh-tunnel-key=/etc/certs/tunnel-private.pem&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;]
+                        name: &#34;expiditer&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1235,8 +1352,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;expiditer&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     headchef: &#123;
@@ -1246,21 +1372,21 @@
             name: &#34;headchef&#34;
             labels: &#123;
                 app:       &#34;headchef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;headchef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1269,20 +1395,18 @@
     headchef: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;headchef&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;headchef&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1299,7 +1423,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;headchef&#34;
                         image: &#34;gcr.io/myproj/headchef:v0.2.16&#34;
                         volumeMounts: [&#123;
                             name:      &#34;headchef-disk&#34;
@@ -1313,6 +1436,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-env=prod&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;]
+                        name: &#34;headchef&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1325,8 +1449,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;headchef&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     linecook: &#123;
@@ -1336,21 +1469,21 @@
             name: &#34;linecook&#34;
             labels: &#123;
                 app:       &#34;linecook&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;linecook&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1359,20 +1492,18 @@
     linecook: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;linecook&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;linecook&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1389,7 +1520,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;linecook&#34;
                         image: &#34;gcr.io/myproj/linecook:v0.1.42&#34;
                         volumeMounts: [&#123;
                             name:      &#34;linecook-disk&#34;
@@ -1403,6 +1533,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-name=linecook&#34;, &#34;-env=prod&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;, &#34;-etcd&#34;, &#34;etcd:2379&#34;, &#34;-reconnect-delay&#34;, &#34;1h&#34;, &#34;-recovery-overlap&#34;, &#34;100000&#34;]
+                        name: &#34;linecook&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1415,8 +1546,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;linecook&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     pastrychef: &#123;
@@ -1426,21 +1566,21 @@
             name: &#34;pastrychef&#34;
             labels: &#123;
                 app:       &#34;pastrychef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;pastrychef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1449,20 +1589,18 @@
     pastrychef: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;pastrychef&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
                     labels: &#123;
                         app:       &#34;pastrychef&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
-                    &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
@@ -1479,7 +1617,6 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;pastrychef&#34;
                         image: &#34;gcr.io/myproj/pastrychef:v0.1.15&#34;
                         volumeMounts: [&#123;
                             name:      &#34;pastrychef-disk&#34;
@@ -1493,6 +1630,7 @@
                             containerPort: 8080
                         &#125;]
                         args: [&#34;-env=prod&#34;, &#34;-ssh-tunnel-key=/etc/certs/tunnel-private.pem&#34;, &#34;-logdir=/logs&#34;, &#34;-event-server=events:7788&#34;, &#34;-reconnect-delay=1m&#34;, &#34;-etcd=etcd:2379&#34;, &#34;-recovery-overlap=10000&#34;]
+                        name: &#34;pastrychef&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1505,8 +1643,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;pastrychef&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     souschef: &#123;
@@ -1516,21 +1663,21 @@
             name: &#34;souschef&#34;
             labels: &#123;
                 app:       &#34;souschef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
         spec: &#123;
             ports: [&#123;
                 port:       8080
-                targetPort: 8080
                 protocol:   &#34;TCP&#34;
+                targetPort: 8080
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
                 app:       &#34;souschef&#34;
-                component: &#34;kitchen&#34;
                 domain:    &#34;prod&#34;
+                component: &#34;kitchen&#34;
             &#125;
         &#125;
     &#125;
@@ -1539,26 +1686,24 @@
     souschef: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;souschef&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
                         app:       &#34;souschef&#34;
-                        component: &#34;kitchen&#34;
                         domain:    &#34;prod&#34;
+                        component: &#34;kitchen&#34;
                     &#125;
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;souschef&#34;
                         image: &#34;gcr.io/myproj/souschef:v0.5.3&#34;
                         ports: [&#123;
                             containerPort: 8080
                         &#125;]
+                        name: &#34;souschef&#34;
                         livenessProbe: &#123;
                             httpGet: &#123;
                                 path: &#34;/debug/health&#34;
@@ -1571,11 +1716,23 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;souschef&#34;
+            labels: &#123;
+                component: &#34;kitchen&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     alertmanager: &#123;
@@ -1586,54 +1743,27 @@
                 &#34;prometheus.io/scrape&#34;: &#34;true&#34;
                 &#34;prometheus.io/path&#34;:   &#34;/metrics&#34;
             &#125;
+            name: &#34;alertmanager&#34;
             labels: &#123;
                 name:      &#34;alertmanager&#34;
                 app:       &#34;alertmanager&#34;
                 domain:    &#34;prod&#34;
                 component: &#34;mon&#34;
             &#125;
-            name: &#34;alertmanager&#34;
         &#125;
         spec: &#123;
-            selector: &#123;
-                app:       &#34;alertmanager&#34;
-                name:      &#34;alertmanager&#34;
-                domain:    &#34;prod&#34;
-                component: &#34;mon&#34;
-            &#125;
             ports: [&#123;
-                name:       &#34;main&#34;
-                protocol:   &#34;TCP&#34;
                 port:       9093
+                protocol:   &#34;TCP&#34;
+                name:       &#34;main&#34;
                 targetPort: 9093
             &#125;]
-        &#125;
-    &#125;
-&#125;
-configMap: &#123;
-    alertmanager: &#123;
-        apiVersion: &#34;v1&#34;
-        kind:       &#34;ConfigMap&#34;
-        metadata: &#123;
+            selector: &#123;
             name: &#34;alertmanager&#34;
+                app:       &#34;alertmanager&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
         &#125;
-        data: &#123;
-            &#34;alerts.yaml&#34;: &#34;&#34;&#34;
-                receivers:
-                - name: pager
-                  slack_configs:
-                  - channel: &#39;#cloudmon&#39;
-                    text: |-
-                      &#123;&#123; range .Alerts &#125;&#125;&#123;&#123; .Annotations.description &#125;&#125;
-                      &#123;&#123; end &#125;&#125;
-                    send_resolved: true
-                route:
-                  receiver: pager
-                  group_by:
-                  - alertname
-                  - cluster
-
-                &#34;&#34;&#34;
         &#125;
     &#125;
 &#125;
@@ -1641,16 +1771,13 @@
     alertmanager: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;alertmanager&#34;
-        &#125;
         spec: &#123;
-            replicas: 1
             selector: &#123;
                 matchLabels: &#123;
                     app: &#34;alertmanager&#34;
                 &#125;
             &#125;
+            replicas: 1
             template: &#123;
                 metadata: &#123;
                     name: &#34;alertmanager&#34;
@@ -1662,13 +1789,13 @@
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;alertmanager&#34;
                         image: &#34;prom/alertmanager:v0.15.2&#34;
                         args: [&#34;--config.file=/etc/alertmanager/alerts.yaml&#34;, &#34;--storage.path=/alertmanager&#34;, &#34;--web.external-url=https://alertmanager.example.com&#34;]
                         ports: [&#123;
                             name:          &#34;alertmanager&#34;
                             containerPort: 9093
                         &#125;]
+                        name: &#34;alertmanager&#34;
                         volumeMounts: [&#123;
                             name:      &#34;config-volume&#34;
                             mountPath: &#34;/etc/alertmanager&#34;
@@ -1689,6 +1816,44 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;alertmanager&#34;
+            labels: &#123;
+                component: &#34;mon&#34;
+            &#125;
+        &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;
+    alertmanager: &#123;
+        apiVersion: &#34;v1&#34;
+        kind:       &#34;ConfigMap&#34;
+        data: &#123;
+            &#34;alerts.yaml&#34;: &#34;&#34;&#34;
+                receivers:
+                - name: pager
+                  slack_configs:
+                  - channel: &#39;#cloudmon&#39;
+                    text: |-
+                      &#123;&#123; range .Alerts &#125;&#125;&#123;&#123; .Annotations.description &#125;&#125;
+                      &#123;&#123; end &#125;&#125;
+                    send_resolved: true
+                route:
+                  receiver: pager
+                  group_by:
+                  - alertname
+                  - cluster
+
+                &#34;&#34;&#34;
+        &#125;
+        metadata: &#123;
+            name: &#34;alertmanager&#34;
+            labels: &#123;
+                component: &#34;mon&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
 // ---
@@ -1705,17 +1870,17 @@
             &#125;
         &#125;
         spec: &#123;
-            selector: &#123;
-                app:       &#34;grafana&#34;
-                domain:    &#34;prod&#34;
-                component: &#34;mon&#34;
-            &#125;
             ports: [&#123;
                 name:       &#34;grafana&#34;
-                protocol:   &#34;TCP&#34;
                 port:       3000
+                protocol:   &#34;TCP&#34;
                 targetPort: 3000
             &#125;]
+            selector: &#123;
+                app:       &#34;grafana&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
         &#125;
     &#125;
 &#125;
@@ -1724,14 +1889,15 @@
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
         metadata: &#123;
-            name: &#34;grafana&#34;
             labels: &#123;
                 app:       &#34;grafana&#34;
                 component: &#34;mon&#34;
             &#125;
+            name: &#34;grafana&#34;
         &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
@@ -1750,7 +1916,6 @@
                     &#125;]
                     containers: [&#123;
                         image: &#34;grafana/grafana:4.5.2&#34;
-                        name:  &#34;grafana&#34;
                         ports: [&#123;
                             containerPort: 8080
                         &#125;]
@@ -1774,6 +1939,7 @@
                             name:  &#34;GF_AUTH_ANONYMOUS_ORG_ROLE&#34;
                             value: &#34;admin&#34;
                         &#125;]
+                        name: &#34;grafana&#34;
                         volumeMounts: [&#123;
                             name:      &#34;grafana-volume&#34;
                             mountPath: &#34;/var/lib/grafana&#34;
@@ -1784,29 +1950,33 @@
         &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     &#34;node-exporter&#34;: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;Service&#34;
         metadata: &#123;
+            annotations: &#123;
+                &#34;prometheus.io/scrape&#34;: &#34;true&#34;
+            &#125;
+            name: &#34;node-exporter&#34;
             labels: &#123;
                 app:       &#34;node-exporter&#34;
                 domain:    &#34;prod&#34;
                 component: &#34;mon&#34;
             &#125;
-            annotations: &#123;
-                &#34;prometheus.io/scrape&#34;: &#34;true&#34;
-            &#125;
-            name: &#34;node-exporter&#34;
         &#125;
         spec: &#123;
             type:      &#34;ClusterIP&#34;
             clusterIP: &#34;None&#34;
             ports: [&#123;
-                name:     &#34;metrics&#34;
                 port:     9100
                 protocol: &#34;TCP&#34;
+                name:       &#34;metrics&#34;
+                targetPort: 9100
             &#125;]
             selector: &#123;
                 app:       &#34;node-exporter&#34;
@@ -1821,16 +1991,15 @@
     &#34;node-exporter&#34;: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;DaemonSet&#34;
-        metadata: &#123;
-            name: &#34;node-exporter&#34;
-        &#125;
         spec: &#123;
             template: &#123;
                 metadata: &#123;
+                    name: &#34;node-exporter&#34;
                     labels: &#123;
                         app: &#34;node-exporter&#34;
+                        component: &#34;mon&#34;
+                        domain:    &#34;prod&#34;
                     &#125;
-                    name: &#34;node-exporter&#34;
                 &#125;
                 spec: &#123;
                     hostNetwork: true
@@ -1838,7 +2007,6 @@
                     containers: [&#123;
                         image: &#34;quay.io/prometheus/node-exporter:v0.16.0&#34;
                         args: [&#34;--path.procfs=/host/proc&#34;, &#34;--path.sysfs=/host/sys&#34;]
-                        name: &#34;node-exporter&#34;
                         ports: [&#123;
                             containerPort: 9100
                             hostPort:      9100
@@ -1854,6 +2022,7 @@
                                 cpu:    &#34;200m&#34;
                             &#125;
                         &#125;
+                        name: &#34;node-exporter&#34;
                         volumeMounts: [&#123;
                             name:      &#34;proc&#34;
                             readOnly:  true
@@ -1877,9 +2046,18 @@
                     &#125;]
                 &#125;
             &#125;
+            selector: &#123;&#125;
         &#125;
+        metadata: &#123;
+            name: &#34;node-exporter&#34;
+            labels: &#123;
+                component: &#34;mon&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     prometheus: &#123;
@@ -1889,38 +2067,99 @@
             annotations: &#123;
                 &#34;prometheus.io/scrape&#34;: &#34;true&#34;
             &#125;
+            name: &#34;prometheus&#34;
             labels: &#123;
                 name:      &#34;prometheus&#34;
                 app:       &#34;prometheus&#34;
                 domain:    &#34;prod&#34;
                 component: &#34;mon&#34;
             &#125;
+        &#125;
+        spec: &#123;
+            type: &#34;NodePort&#34;
+            ports: [&#123;
+                port:       9090
+                protocol:   &#34;TCP&#34;
+                name:       &#34;main&#34;
+                nodePort:   30900
+                targetPort: 9090
+            &#125;]
+            selector: &#123;
             name: &#34;prometheus&#34;
+                app:       &#34;prometheus&#34;
+                domain:    &#34;prod&#34;
+                component: &#34;mon&#34;
+            &#125;
+        &#125;
+    &#125;
         &#125;
+deployment: &#123;
+    prometheus: &#123;
+        apiVersion: &#34;apps/v1&#34;
+        kind:       &#34;Deployment&#34;
         spec: &#123;
+            strategy: &#123;
+                rollingUpdate: &#123;
+                    maxSurge:       0
+                    maxUnavailable: 1
+                &#125;
+                type: &#34;RollingUpdate&#34;
+            &#125;
             selector: &#123;
+                matchLabels: &#123;
                 app:       &#34;prometheus&#34;
+                &#125;
+            &#125;
+            replicas: 1
+            template: &#123;
+                metadata: &#123;
                 name:      &#34;prometheus&#34;
+                    labels: &#123;
+                        app:       &#34;prometheus&#34;
                 domain:    &#34;prod&#34;
                 component: &#34;mon&#34;
             &#125;
-            type: &#34;NodePort&#34;
+                    annotations: &#123;
+                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
+                    &#125;
+                &#125;
+                spec: &#123;
+                    containers: [&#123;
+                        image: &#34;prom/prometheus:v2.4.3&#34;
+                        args: [&#34;--config.file=/etc/prometheus/prometheus.yml&#34;, &#34;--web.external-url=https://prometheus.example.com&#34;]
             ports: [&#123;
-                name:     &#34;main&#34;
-                protocol: &#34;TCP&#34;
-                port:     9090
-                nodePort: 30900
+                            name:          &#34;web&#34;
+                            containerPort: 9090
+                        &#125;]
+                        name: &#34;prometheus&#34;
+                        volumeMounts: [&#123;
+                            name:      &#34;config-volume&#34;
+                            mountPath: &#34;/etc/prometheus&#34;
+                        &#125;]
             &#125;]
+                    volumes: [&#123;
+                        name: &#34;config-volume&#34;
+                        configMap: &#123;
+                            name: &#34;prometheus&#34;
+                        &#125;
+                    &#125;]
+                &#125;
+            &#125;
+        &#125;
+        metadata: &#123;
+            name: &#34;prometheus&#34;
+            labels: &#123;
+                component: &#34;mon&#34;
+            &#125;
         &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
 configMap: &#123;
     prometheus: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;ConfigMap&#34;
-        metadata: &#123;
-            name: &#34;prometheus&#34;
-        &#125;
         data: &#123;
             &#34;alert.rules&#34;: &#34;&#34;&#34;
                 groups:
@@ -2150,69 +2389,20 @@
 
                 &#34;&#34;&#34;
         &#125;
-    &#125;
-&#125;
-deployment: &#123;
-    prometheus: &#123;
-        apiVersion: &#34;apps/v1&#34;
-        kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;prometheus&#34;
-        &#125;
-        spec: &#123;
-            replicas: 1
-            strategy: &#123;
-                rollingUpdate: &#123;
-                    maxSurge:       0
-                    maxUnavailable: 1
-                &#125;
-                type: &#34;RollingUpdate&#34;
-            &#125;
-            selector: &#123;
-                matchLabels: &#123;
-                    app: &#34;prometheus&#34;
-                &#125;
-            &#125;
-            template: &#123;
                 metadata: &#123;
                     name: &#34;prometheus&#34;
                     labels: &#123;
-                        app:       &#34;prometheus&#34;
-                        domain:    &#34;prod&#34;
                         component: &#34;mon&#34;
                     &#125;
-                    annotations: &#123;
-                        &#34;prometheus.io.scrape&#34;: &#34;true&#34;
-                    &#125;
-                &#125;
-                spec: &#123;
-                    containers: [&#123;
-                        name:  &#34;prometheus&#34;
-                        image: &#34;prom/prometheus:v2.4.3&#34;
-                        args: [&#34;--config.file=/etc/prometheus/prometheus.yml&#34;, &#34;--web.external-url=https://prometheus.example.com&#34;]
-                        ports: [&#123;
-                            name:          &#34;web&#34;
-                            containerPort: 9090
-                        &#125;]
-                        volumeMounts: [&#123;
-                            name:      &#34;config-volume&#34;
-                            mountPath: &#34;/etc/prometheus&#34;
-                        &#125;]
-                    &#125;]
-                    volumes: [&#123;
-                        name: &#34;config-volume&#34;
-                        configMap: &#123;
-                            name: &#34;prometheus&#34;
-                        &#125;
-                    &#125;]
-                &#125;
-            &#125;
         &#125;
     &#125;
 &#125;
 // ---
 service: &#123;&#125;
 deployment: &#123;&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     authproxy: &#123;
@@ -2229,8 +2419,8 @@
         spec: &#123;
             ports: [&#123;
                 port:       4180
-                targetPort: 4180
                 protocol:   &#34;TCP&#34;
+                targetPort: 4180
                 name:       &#34;client&#34;
             &#125;]
             selector: &#123;
@@ -2245,11 +2435,9 @@
     authproxy: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;authproxy&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
@@ -2260,12 +2448,12 @@
                 &#125;
                 spec: &#123;
                     containers: [&#123;
-                        name:  &#34;authproxy&#34;
                         image: &#34;skippy/oauth2_proxy:2.0.1&#34;
                         ports: [&#123;
                             containerPort: 4180
                         &#125;]
                         args: [&#34;--config=/etc/authproxy/authproxy.cfg&#34;]
+                        name: &#34;authproxy&#34;
                         volumeMounts: [&#123;
                             name:      &#34;config-volume&#34;
                             mountPath: &#34;/etc/authproxy&#34;
@@ -2280,15 +2468,20 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;authproxy&#34;
+            labels: &#123;
+                component: &#34;proxy&#34;
+            &#125;
     &#125;
 &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
 configMap: &#123;
     authproxy: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;ConfigMap&#34;
-        metadata: &#123;
-            name: &#34;authproxy&#34;
-        &#125;
         data: &#123;
             &#34;authproxy.cfg&#34;: &#34;&#34;&#34;
                 # Google Auth Proxy Config File
@@ -2344,6 +2537,12 @@
                 cookie_https_only = true
                 &#34;&#34;&#34;
         &#125;
+        metadata: &#123;
+            name: &#34;authproxy&#34;
+            labels: &#123;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
 // ---
@@ -2364,9 +2563,9 @@
             loadBalancerIP: &#34;1.3.5.7&#34;
             ports: [&#123;
                 port:       443
-                targetPort: 7443
                 protocol:   &#34;TCP&#34;
                 name:       &#34;https&#34;
+                targetPort: 7443
             &#125;]
             selector: &#123;
                 app:       &#34;goget&#34;
@@ -2380,11 +2579,9 @@
     goget: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;goget&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
@@ -2401,11 +2598,11 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;goget&#34;
                         image: &#34;gcr.io/myproj/goget:v0.5.1&#34;
                         ports: [&#123;
                             containerPort: 7443
                         &#125;]
+                        name: &#34;goget&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/ssl&#34;
                             name:      &#34;secret-volume&#34;
@@ -2414,8 +2611,17 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;goget&#34;
+            labels: &#123;
+                component: &#34;proxy&#34;
     &#125;
 &#125;
+    &#125;
+&#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
+configMap: &#123;&#125;
 // ---
 service: &#123;
     nginx: &#123;
@@ -2434,13 +2640,14 @@
             loadBalancerIP: &#34;1.3.4.5&#34;
             ports: [&#123;
                 port:       80
-                targetPort: 80
                 protocol:   &#34;TCP&#34;
                 name:       &#34;http&#34;
+                targetPort: 80
             &#125;, &#123;
                 port:     443
                 protocol: &#34;TCP&#34;
                 name:     &#34;https&#34;
+                targetPort: 443
             &#125;]
             selector: &#123;
                 app:       &#34;nginx&#34;
@@ -2454,11 +2661,9 @@
     nginx: &#123;
         apiVersion: &#34;apps/v1&#34;
         kind:       &#34;Deployment&#34;
-        metadata: &#123;
-            name: &#34;nginx&#34;
-        &#125;
         spec: &#123;
             replicas: 1
+            selector: &#123;&#125;
             template: &#123;
                 metadata: &#123;
                     labels: &#123;
@@ -2480,13 +2685,13 @@
                         &#125;
                     &#125;]
                     containers: [&#123;
-                        name:  &#34;nginx&#34;
                         image: &#34;nginx:1.11.10-alpine&#34;
                         ports: [&#123;
                             containerPort: 80
                         &#125;, &#123;
                             containerPort: 443
                         &#125;]
+                        name: &#34;nginx&#34;
                         volumeMounts: [&#123;
                             mountPath: &#34;/etc/ssl&#34;
                             name:      &#34;secret-volume&#34;
@@ -2499,15 +2704,20 @@
                 &#125;
             &#125;
         &#125;
+        metadata: &#123;
+            name: &#34;nginx&#34;
+            labels: &#123;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
+daemonSet: &#123;&#125;
+statefulSet: &#123;&#125;
 configMap: &#123;
     nginx: &#123;
         apiVersion: &#34;v1&#34;
         kind:       &#34;ConfigMap&#34;
-        metadata: &#123;
-            name: &#34;nginx&#34;
-        &#125;
         data: &#123;
             &#34;nginx.conf&#34;: &#34;&#34;&#34;
                 events &#123;
@@ -2664,5 +2874,11 @@
                 &#125;
                 &#34;&#34;&#34;
         &#125;
+        metadata: &#123;
+            name: &#34;nginx&#34;
+            labels: &#123;
+                component: &#34;proxy&#34;
+            &#125;
+        &#125;
     &#125;
 &#125;
$ cp snapshot2 snapshot
</code></pre>

Two lines with annotations added, improving consistency.

<pre data-command-src="Y3VlIHRyaW0gLXMgLi9mcm9udGVuZC8uLi4KZmluZCAuIHwgZ3JlcCBrdWJlLmN1ZSB8IHhhcmdzIHdjIHwgdGFpbCAtMQo="><code class="language-.term1">$ cue trim -s ./frontend/...
$ find . | grep kube.cue | xargs wc | tail -1
 1062  2156 20748 total
</code></pre>

Another 40 lines removed.
We may have gotten used to larger reductions, but at this point there is just
not much left to remove: in some of the frontend files there are only 4 lines
of configuration left.


#### Directory `kitchen`

In this directory we observe that all deployments have without exception
one container with port `8080`, all have the same liveness probe,
a single line of prometheus annotation, and most have
two or three disks with similar patterns.

Let's add everything but the disks for now:

<pre data-command-src="Y2F0IDw8RU9GID4+a2l0Y2hlbi9rdWJlLmN1ZQoKZGVwbG95bWVudDogW3N0cmluZ106IHNwZWM6IHRlbXBsYXRlOiB7CgltZXRhZGF0YTogYW5ub3RhdGlvbnM6ICJwcm9tZXRoZXVzLmlvLnNjcmFwZSI6ICJ0cnVlIgoJc3BlYzogY29udGFpbmVyczogW3sKCQlwb3J0czogW3sKCQkJY29udGFpbmVyUG9ydDogODA4MAoJCX1dCgkJbGl2ZW5lc3NQcm9iZTogewoJCQlodHRwR2V0OiB7CgkJCQlwYXRoOiAiL2RlYnVnL2hlYWx0aCIKCQkJCXBvcnQ6IDgwODAKCQkJfQoJCQlpbml0aWFsRGVsYXlTZWNvbmRzOiA0MAoJCQlwZXJpb2RTZWNvbmRzOiAgICAgICAzCgkJfQoJfV0KfQpFT0YKY3VlIGZtdCAuL2tpdGNoZW4K"><code class="language-.term1">$ cat &lt;&lt;EOF &gt;&gt;kitchen/kube.cue

deployment: [string]: spec: template: &#123;
	metadata: annotations: &#34;prometheus.io.scrape&#34;: &#34;true&#34;
	spec: containers: [&#123;
		ports: [&#123;
			containerPort: 8080
		&#125;]
		livenessProbe: &#123;
			httpGet: &#123;
				path: &#34;/debug/health&#34;
				port: 8080
			&#125;
			initialDelaySeconds: 40
			periodSeconds:       3
		&#125;
	&#125;]
&#125;
EOF
$ cue fmt ./kitchen
</code></pre>

A diff reveals that one prometheus annotation was added to a service.
We assume this to be an accidental omission and accept the differences

Disks need to be defined in both the template spec section as well as in
the container where they are used.
We prefer to keep these two definitions together.
We take the volumes definition from `expiditer` (the first config in that
directory with two disks), and generalize it:

<pre data-command-src="Y2F0IDw8RU9GID4+a2l0Y2hlbi9rdWJlLmN1ZQoKZGVwbG95bWVudDogW0lEPV9dOiBzcGVjOiB0ZW1wbGF0ZTogc3BlYzogewoJX2hhc0Rpc2tzOiAqdHJ1ZSB8IGJvb2wKCgkvLyBmaWVsZCBjb21wcmVoZW5zaW9uIHVzaW5nIGp1c3QgImlmIgoJaWYgX2hhc0Rpc2tzIHsKCQl2b2x1bWVzOiBbewoJCQluYW1lOiAqIlwoSUQpLWRpc2siIHwgc3RyaW5nCgkJCWdjZVBlcnNpc3RlbnREaXNrOiBwZE5hbWU6ICoiXChJRCktZGlzayIgfCBzdHJpbmcKCQkJZ2NlUGVyc2lzdGVudERpc2s6IGZzVHlwZTogImV4dDQiCgkJfSwgewoJCQluYW1lOiAqInNlY3JldC1cKElEKSIgfCBzdHJpbmcKCQkJc2VjcmV0OiBzZWNyZXROYW1lOiAqIlwoSUQpLXNlY3JldHMiIHwgc3RyaW5nCgkJfSwgLi4uXQoKCQljb250YWluZXJzOiBbewoJCQl2b2x1bWVNb3VudHM6IFt7CgkJCQluYW1lOiAgICAgICoiXChJRCktZGlzayIgfCBzdHJpbmcKCQkJCW1vdW50UGF0aDogKiIvbG9ncyIgfCBzdHJpbmcKCQkJfSwgewoJCQkJbW91bnRQYXRoOiAqIi9ldGMvY2VydHMiIHwgc3RyaW5nCgkJCQluYW1lOiAgICAgICoic2VjcmV0LVwoSUQpIiB8IHN0cmluZwoJCQkJcmVhZE9ubHk6ICB0cnVlCgkJCX0sIC4uLl0KCQl9XQoJfQp9CkVPRgpjdWUgZm10IC4va2l0Y2hlbgpjYXQgPDxFT0YgPj5raXRjaGVuL3NvdXNjaGVmL2t1YmUuY3VlCgpkZXBsb3ltZW50OiBzb3VzY2hlZjogc3BlYzogdGVtcGxhdGU6IHNwZWM6IHsKCSBfaGFzRGlza3M6IGZhbHNlCn0KCkVPRgpjdWUgZm10IC4va2l0Y2hlbi8uLi4K"><code class="language-.term1">$ cat &lt;&lt;EOF &gt;&gt;kitchen/kube.cue

deployment: [ID=_]: spec: template: spec: &#123;
	_hasDisks: *true | bool

	// field comprehension using just &#34;if&#34;
	if _hasDisks &#123;
		volumes: [&#123;
			name: *&#34;\(ID)-disk&#34; | string
			gcePersistentDisk: pdName: *&#34;\(ID)-disk&#34; | string
			gcePersistentDisk: fsType: &#34;ext4&#34;
		&#125;, &#123;
			name: *&#34;secret-\(ID)&#34; | string
			secret: secretName: *&#34;\(ID)-secrets&#34; | string
		&#125;, ...]

		containers: [&#123;
			volumeMounts: [&#123;
				name:      *&#34;\(ID)-disk&#34; | string
				mountPath: *&#34;/logs&#34; | string
			&#125;, &#123;
				mountPath: *&#34;/etc/certs&#34; | string
				name:      *&#34;secret-\(ID)&#34; | string
				readOnly:  true
			&#125;, ...]
		&#125;]
	&#125;
&#125;
EOF
$ cue fmt ./kitchen
$ cat &lt;&lt;EOF &gt;&gt;kitchen/souschef/kube.cue

deployment: souschef: spec: template: spec: &#123;
	 _hasDisks: false
&#125;

EOF
$ cue fmt ./kitchen/...
</code></pre>

This template definition is not ideal: the definitions are positional, so if
configurations were to define the disks in a different order, there would be
no reuse or even conflicts.
Also note that in order to deal with this restriction, almost all field values
are just default values and can be overridden by instances.
A better way would be define a map of volumes,
similarly to how we organized the top-level Kubernetes objects,
and then generate these two sections from this map.
This requires some design, though, and does not belong in a
"quick-and-dirty" tutorial.
Later in this document we introduce a manually optimized configuration.

We add the two disk by default and define a `_hasDisks` option to opt out.
The `souschef` configuration is the only one that defines no disks.

<pre data-command-src="Y3VlIHRyaW0gLXMgLi9raXRjaGVuLy4uLgpjdWUgZXZhbCAuLy4uLiA+c25hcHNob3QyCmRpZmYgc25hcHNob3Qgc25hcHNob3QyCmNwIHNuYXBzaG90MiBzbmFwc2hvdApmaW5kIC4gfCBncmVwIGt1YmUuY3VlIHwgeGFyZ3Mgd2MgfCB0YWlsIC0xCg=="><code class="language-.term1">$ cue trim -s ./kitchen/...
$ cue eval ./... &gt;snapshot2
$ diff snapshot snapshot2
2a3
&gt; #Component: string
8a10
&gt; #Component: &#34;frontend&#34;
49,52d50
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
57a56,59
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
61a64
&gt;                         name:  &#34;bartender&#34;
65d67
&lt;                         name: &#34;bartender&#34;
78a81
&gt; #Component: &#34;frontend&#34;
119,122d121
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
127a127,130
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
131a135
&gt;                         name:  &#34;breaddispatcher&#34;
135d138
&lt;                         name: &#34;breaddispatcher&#34;
148a152
&gt; #Component: &#34;frontend&#34;
189,192d192
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
197a198,201
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
201a206
&gt;                         name:  &#34;host&#34;
205d209
&lt;                         name: &#34;host&#34;
218a223
&gt; #Component: &#34;frontend&#34;
259,262d263
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
267a269,272
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
271a277
&gt;                         name:  &#34;maitred&#34;
275d280
&lt;                         name: &#34;maitred&#34;
288a294
&gt; #Component: &#34;frontend&#34;
329,332d334
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;8080&#34;
&lt;                     &#125;
337a340,343
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;8080&#34;
&gt;                     &#125;
358a365
&gt; #Component: &#34;frontend&#34;
399,402d405
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
407a411,414
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
427a435
&gt; #Component: &#34;frontend&#34;
468,471d475
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&lt;                     &#125;
476a481,484
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                         &#34;prometheus.io.port&#34;:   &#34;7080&#34;
&gt;                     &#125;
480a489
&gt;                         name:  &#34;waterdispatcher&#34;
484d492
&lt;                         name: &#34;waterdispatcher&#34;
497a506
&gt; #Component: &#34;frontend&#34;
503a513
&gt; #Component: &#34;infra&#34;
568a579
&gt; #Component: &#34;infra&#34;
606a618
&gt; #Component: &#34;infra&#34;
809a822
&gt; #Component: &#34;infra&#34;
892a906
&gt; #Component: &#34;infra&#34;
968a983
&gt; #Component: &#34;infra&#34;
1047a1063
&gt; #Component: &#34;infra&#34;
1053a1070
&gt; #Component: &#34;kitchen&#34;
1094,1096d1110
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1101a1116,1118
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1134a1152
&gt;                         name: &#34;caller&#34;
1139d1156
&lt;                         name: &#34;caller&#34;
1159a1177
&gt; #Component: &#34;kitchen&#34;
1200,1202d1217
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1207a1223,1225
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1240a1259
&gt;                         name: &#34;dishwasher&#34;
1245d1263
&lt;                         name: &#34;dishwasher&#34;
1265a1284
&gt; #Component: &#34;kitchen&#34;
1306,1308d1324
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1313a1330,1332
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1329a1349,1352
&gt;                         name:  &#34;expiditer&#34;
&gt;                         ports: [&#123;
&gt;                             containerPort: 8080
&gt;                         &#125;]
1338,1340d1360
&lt;                         ports: [&#123;
&lt;                             containerPort: 8080
&lt;                         &#125;]
1342d1361
&lt;                         name: &#34;expiditer&#34;
1362a1382
&gt; #Component: &#34;kitchen&#34;
1403,1405d1422
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1410a1428,1430
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1434a1455
&gt;                         name: &#34;headchef&#34;
1439d1459
&lt;                         name: &#34;headchef&#34;
1459a1480
&gt; #Component: &#34;kitchen&#34;
1500,1502d1520
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1507a1526,1528
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1531a1553
&gt;                         name: &#34;linecook&#34;
1536d1557
&lt;                         name: &#34;linecook&#34;
1556a1578
&gt; #Component: &#34;kitchen&#34;
1597,1599d1618
&lt;                     annotations: &#123;
&lt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&lt;                     &#125;
1604a1624,1626
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1628a1651
&gt;                         name: &#34;pastrychef&#34;
1633d1655
&lt;                         name: &#34;pastrychef&#34;
1653a1676
&gt; #Component: &#34;kitchen&#34;
1698a1722,1724
&gt;                     annotations: &#123;
&gt;                         &#34;prometheus.io.scrape&#34;: &#34;true&#34;
&gt;                     &#125;
1702a1729
&gt;                         name:  &#34;souschef&#34;
1706d1732
&lt;                         name: &#34;souschef&#34;
1726a1753
&gt; #Component: &#34;kitchen&#34;
1732a1760
&gt; #Component: &#34;mon&#34;
1826a1855
&gt; #Component: &#34;mon&#34;
1952a1982
&gt; #Component: &#34;mon&#34;
1989a2020
&gt; #Component: &#34;mon&#34;
2156a2188
&gt; #Component: &#34;mon&#34;
2402a2435
&gt; #Component: &#34;proxy&#34;
2478a2512
&gt; #Component: &#34;proxy&#34;
2621a2656
&gt; #Component: &#34;proxy&#34;
2714a2750
&gt; #Component: &#34;proxy&#34;
$ cp snapshot2 snapshot
$ find . | grep kube.cue | xargs wc | tail -1
  935  1966 18279 total
</code></pre>

The diff shows that we added the `_hadDisks` option, but otherwise reveals no
differences.
We also reduced the configuration by a sizeable amount once more.

However, on closer inspection of the remaining files we see a lot of remaining
fields in the disk specifications as a result of inconsistent naming.
Reducing configurations like we did in this exercise exposes inconsistencies.
The inconsistencies can be removed by simply deleting the overrides in the
specific configuration.
Leaving them as is gives a clear signal that a configuration is inconsistent.


### Conclusion of Quick 'n Dirty tutorial

There is still some gain to be made with the other directories.
At nearly a 1000-line, or 55%, reduction, we leave the rest as an exercise to
the reader.

We have shown how CUE can be used to reduce boilerplate, enforce consistencies,
and detect inconsistencies.
Being able to deal with consistencies and inconsistencies is a consequence of
the constraint-based model and harder to do with inheritance-based languages.

We have indirectly also shown how CUE is well-suited for machine manipulation.
This is a factor of syntax and the order independence that follows from its
semantics.
The `trim` command is one of many possible automated refactor tools made
possible by this property.
Also this would be harder to do with inheritance-based configuration languages.


## Define commands

The `cue export` command can be used to convert the created configuration back
to JSON.
In our case, this requires a top-level "emit value"
to convert our mapped Kubernetes objects back to a list.
Typically, this output is piped to tools like `kubectl` or `etcdctl`.

In practice this means typing the same commands ad nauseam.
The next step is often to write wrapper tools.
But as there is often no one-size-fits-all solution, this lead to the
proliferation of marginally useful tools.
The `cue` tool provides an alternative by allowing the declaration of
frequently used commands in CUE itself.
Advantages:

- added domain knowledge that CUE may use for improved analysis,
- only one language to learn,
- easy discovery of commands,
- no further configuration required,
- enforce uniform CLI standards across commands,
- standardized commands across an organization.

Commands are defined in files ending with `_tool.cue` in the same package as
where the configuration files are defined on which the commands should operate.
Top-level values in the configuration are visible by the tool files
as long as they are not shadowed by top-level fields in the tool files.
Top-level fields in the tool files are not visible in the configuration files
and are not part of any model.

The tool definitions also have access to additional builtin packages.
A CUE configuration is fully hermetic, disallowing any outside influence.
This property enables automated analysis and manipulation
such as the `trim` command.
The tool definitions, however, have access to such things as command line flags
and environment variables, random generators, file listings, and so on.

We define the following tools for our example:

- ls: list the Kubernetes objects defined in our configuration
- dump: dump all selected objects as a YAML stream
- create: send all selected objects to `kubectl` for creation

### Preparations

To work with Kubernetes we need to convert our map of Kubernetes objects
back to a simple list.
We create the tool file to do just that.

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="a3ViZV90b29sLmN1ZQ==:cGFja2FnZSBrdWJlCgpvYmplY3RzOiBbIGZvciB2IGluIG9iamVjdFNldHMgZm9yIHggaW4gdiB7eH1dCgpvYmplY3RTZXRzOiBbCglzZXJ2aWNlLAoJZGVwbG95bWVudCwKCXN0YXRlZnVsU2V0LAoJZGFlbW9uU2V0LAoJY29uZmlnTWFwLApd" data-upload-term=".term1"><code class="language-cue">package kube

objects: [ for v in objectSets for x in v &#123;x&#125;]

objectSets: [
	service,
	deployment,
	statefulSet,
	daemonSet,
	configMap,
]</code></pre>

### Listing objects

Commands are defined in the `command` section at the top-level of a tool file.
A `cue` command defines command line flags, environment variables, as well as
a set of tasks.
Examples tasks are load or write a file, dump something to the console,
download a web page, or execute a command.

We start by defining the `ls` command which dumps all our objects

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="bHNfdG9vbC5jdWU=:cGFja2FnZSBrdWJlCgppbXBvcnQgKAoJInRleHQvdGFid3JpdGVyIgoJInRvb2wvY2xpIgoJInRvb2wvZmlsZSIKKQoKY29tbWFuZDogbHM6IHsKCXRhc2s6IHByaW50OiBjbGkuUHJpbnQgJiB7CgkJdGV4dDogdGFid3JpdGVyLldyaXRlKFsKCQkJZm9yIHggaW4gb2JqZWN0cyB7CgkJCQkiXCh4LmtpbmQpICBcdFwoeC5tZXRhZGF0YS5sYWJlbHMuY29tcG9uZW50KSAgXHRcKHgubWV0YWRhdGEubmFtZSkiCgkJCX0sCgkJXSkKCX0KCgl0YXNrOiB3cml0ZTogZmlsZS5DcmVhdGUgJiB7CgkJZmlsZW5hbWU6ICJmb28udHh0IgoJCWNvbnRlbnRzOiB0YXNrLnByaW50LnRleHQKCX0KfQ==" data-upload-term=".term1"><code class="language-cue">package kube

import (
	&#34;text/tabwriter&#34;
	&#34;tool/cli&#34;
	&#34;tool/file&#34;
)

command: ls: &#123;
	task: print: cli.Print &amp; &#123;
		text: tabwriter.Write([
			for x in objects &#123;
				&#34;\(x.kind)  \t\(x.metadata.labels.component)  \t\(x.metadata.name)&#34;
			&#125;,
		])
	&#125;

	task: write: file.Create &amp; &#123;
		filename: &#34;foo.txt&#34;
		contents: task.print.text
	&#125;
&#125;</code></pre>
<!-- TODO: use "let" once implemented-->

NOTE: THE API OF THE TASK DEFINITIONS WILL CHANGE.
Although we may keep supporting this form if needed.

The command is now available in the `cue` tool:

<pre data-command-src="Y3VlIGNtZCBscyAuL2Zyb250ZW5kL21haXRyZWQK"><code class="language-.term1">$ cue cmd ls ./frontend/maitred
Service      frontend   maitred
Deployment   frontend   maitred

</code></pre>

As long as the name does not conflict with an existing command it can be
used as a top-level command as well:

<pre data-command-src="Y3VlIGxzIC4vZnJvbnRlbmQvbWFpdHJlZAo="><code class="language-.term1">$ cue ls ./frontend/maitred
Service      frontend   maitred
Deployment   frontend   maitred

</code></pre>

If more than one instance is selected the `cue` tool may either operate
on them one by one or merge them.
The default is to merge them.
Different instances of a package are typically not compatible:
different subdirectories may have different specializations.
A merge pre-expands templates of each instance and then merges their root
values.
The result may contain conflicts, such as our top-level `#Component` field,
but our per-type maps of Kubernetes objects should be free of conflict
(if there is, we have a problem with Kubernetes down the line).
A merge thus gives us a unified view of all objects.

<pre data-command-src="Y3VlIGxzIC4vZnJvbnRlbmQvbWFpdHJlZAo="><code class="language-.term1">$ cue ls ./frontend/maitred
Service      frontend   maitred
Deployment   frontend   maitred

</code></pre>

### Dumping a YAML Stream

The following adds a command to dump the selected objects as a YAML stream.

<!--
TODO: add command line flags to filter object types.
-->
<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="ZHVtcF90b29sLmN1ZQ==:cGFja2FnZSBrdWJlCgppbXBvcnQgKAoJImVuY29kaW5nL3lhbWwiCgkidG9vbC9jbGkiCikKCmNvbW1hbmQ6IGR1bXA6IHsKCXRhc2s6IHByaW50OiBjbGkuUHJpbnQgJiB7CgkJdGV4dDogeWFtbC5NYXJzaGFsU3RyZWFtKG9iamVjdHMpCgl9Cn0=" data-upload-term=".term1"><code class="language-cue">package kube

import (
	&#34;encoding/yaml&#34;
	&#34;tool/cli&#34;
)

command: dump: &#123;
	task: print: cli.Print &amp; &#123;
		text: yaml.MarshalStream(objects)
	&#125;
&#125;</code></pre>

<!--
TODO: with new API as well as conversions implemented
command dump task print: cli.Print(text: yaml.MarshalStream(objects))

or without conversions:
command dump task print: cli.Print & {text: yaml.MarshalStream(objects)}
-->

The `MarshalStream` command converts the list of objects to a '`---`'-separated
stream of YAML values.


### Creating Objects

The `create` command sends a list of objects to `kubectl create`.

<pre data-upload-path="L2hvbWUvZ29waGVyL2N1ZS9kb2MvdHV0b3JpYWwva3ViZXJuZXRlcy90bXAvc2VydmljZXM=" data-upload-src="Y3JlYXRlX3Rvb2wuY3Vl:cGFja2FnZSBrdWJlCgppbXBvcnQgKAoJImVuY29kaW5nL3lhbWwiCgkidG9vbC9leGVjIgoJInRvb2wvY2xpIgopCgpjb21tYW5kOiBjcmVhdGU6IHsKCXRhc2s6IGt1YmU6IGV4ZWMuUnVuICYgewoJCWNtZDogICAgImt1YmVjdGwgY3JlYXRlIC0tZHJ5LXJ1bj1jbGllbnQgLWYgLSIKCQlzdGRpbjogIHlhbWwuTWFyc2hhbFN0cmVhbShvYmplY3RzKQoJCXN0ZG91dDogc3RyaW5nCgl9CgoJdGFzazogZGlzcGxheTogY2xpLlByaW50ICYgewoJCXRleHQ6IHRhc2sua3ViZS5zdGRvdXQKCX0KfQ==" data-upload-term=".term1"><code class="language-cue">package kube

import (
	&#34;encoding/yaml&#34;
	&#34;tool/exec&#34;
	&#34;tool/cli&#34;
)

command: create: &#123;
	task: kube: exec.Run &amp; &#123;
		cmd:    &#34;kubectl create --dry-run=client -f -&#34;
		stdin:  yaml.MarshalStream(objects)
		stdout: string
	&#125;

	task: display: cli.Print &amp; &#123;
		text: task.kube.stdout
	&#125;
&#125;</code></pre>

This command has two tasks, named `kube` and `display`.
The `display` task depends on the output of the `kube` task.
The `cue` tool does a static analysis of the dependencies and runs all
tasks which dependencies are satisfied in parallel while blocking tasks
for which an input is missing.

<pre data-command-src="Y3VlIGNyZWF0ZSAuL2Zyb250ZW5kLy4uLgo="><code class="language-.term1">$ cue create ./frontend/...
The connection to the server localhost:8080 was refused - did you specify the right host or port?
task failed: command &#34;kubectl create --dry-run=client -f -&#34; failed: exit status 1
</code></pre>

A production real-life version of this could should omit the `--dry-run` flag
of course.

### Extract CUE templates directly from Kubernetes Go source

In order for `cue get go` to generate the CUE templates from Go sources, you first need to have the sources locally:

```
$ go get k8s.io/api/apps/v1
```

```
$ cue get go k8s.io/api/apps/v1

```

Now that we have the Kubernetes definitions in our module, we can import and use them:

```
$ cat <<EOF > k8s_defs.cue
package kube

import (
  "k8s.io/api/core/v1"
  apps_v1 "k8s.io/api/apps/v1"
)

service: [string]:     v1.#Service
deployment: [string]:  apps_v1.#Deployment
daemonSet: [string]:   apps_v1.#DaemonSet
statefulSet: [string]: apps_v1.#StatefulSet
EOF
```

And, finally, we'll format again:

```
cue fmt
```

## Manually tailored configuration

In Section "Quick 'n Dirty" we showed how to quickly get going with CUE.
With a bit more deliberation, one can reduce configurations even further.
Also, we would like to define a configuration that is more generic and less tied
to Kubernetes.

We will rely heavily on CUEs order independence, which makes it easy to
combine two configurations of the same object in a well-defined way.
This makes it easy, for instance, to put frequently used fields in one file
and more esoteric one in another and then combine them without fear that one
will override the other.
We will take this approach in this section.

The end result of this tutorial is in the `manual` directory.
In the next sections we will show how to get there.


### Outline

The basic premise of our configuration is to maintain two configurations,
a simple and abstract one, and one compatible with Kubernetes.
The Kubernetes version is automatically generated from the simple configuration.
Each simplified object has a `kubernetes` section that get gets merged into
the Kubernetes object upon conversion.

We define one top-level file with our generic definitions.

```
// file cloud.cue
package cloud

service: [Name=_]: {
    name: *Name | string // the name of the service

    ...

    // Kubernetes-specific options that get mixed in when converting
    // to Kubernetes.
    kubernetes: {
    }
}

deployment: [Name=_]: {
    name: *Name | string
   ...
}
```

A Kubernetes-specific file then contains the definitions to
convert the generic objects to Kubernetes.

Overall, the code modeling our services and the code generating the kubernetes
code is separated, while still allowing to inject Kubernetes-specific
data into our general model.
At the same time, we can add additional information to our model without
it ending up in the Kubernetes definitions causing it to barf.


### Deployment Definition

For our design we assume that all Kubernetes Pod derivatives only define one
container.
This is clearly not the case in general, but often it does and it is good
practice.
Conveniently, it simplifies our model as well.

We base the model loosely on the master templates we derived in
Section "Quick 'n Dirty".
The first step we took is to eliminate `statefulSet` and `daemonSet` and
rather just have a `deployment` allowing different kinds.

```
deployment: [Name=_]: _base & {
    name:     *Name | string
    ...
```

The kind only needs to be specified if the deployment is a stateful set or
daemonset.
This also eliminates the need for `_spec`.

The next step is to pull common fields, such as `image` to the top level.

Arguments can be specified as a map.
```
    arg: [string]: string
    args: [ for k, v in arg { "-\(k)=\(v)" } ] | [...string]
```

If order matters, users could explicitly specify the list as well.

For ports we define two simple maps from name to port number:

```
    // expose port defines named ports that is exposed in the service
    expose: port: [string]: int

    // port defines a named port that is not exposed in the service.
    port: [string]: int
```
Both maps get defined in the container definition, but only `port` gets
included in the service definition.
This may not be the best model, and does not support all features,
but it shows how one can chose a different representation.

A similar story holds for environment variables.
In most cases mapping strings to string suffices.
The testdata uses other options though.
We define a simple `env` map and an `envSpec` for more elaborate cases:

```
    env: [string]: string

    envSpec: [string]: {}
    envSpec: {
        for k, v in env {
            "\(k)" value: v
        }
    }
```
The simple map automatically gets mapped into the more elaborate map
which then presents the full picture.

Finally, our assumption that there is one container per deployment allows us
to create a single definition for volumes, combining the information for
volume spec and volume mount.

```
    volume: [Name=_]: {
        name:       *Name | string
        mountPath:  string
        subPath:    null | string
        readOnly:   bool
        kubernetes: {}
    }
```

All other fields that we way want to define can go into a generic kubernetes
struct that gets merged in with all other generated kubernetes data.
This even allows us to augment generated data, such as adding additional
fields to the container.


### Service Definition

The service definition is straightforward.
As we eliminated stateful and daemon sets, the field comprehension to
automatically derive a service is now a bit simpler:

```
// define services implied by deployments
service: {
    for k, spec in deployment {
        "\(k)": {
            // Copy over all ports exposed from containers.
            for Name, Port in spec.expose.port {
                port: "\(Name)": {
                    port:       *Port | int
                    targetPort: *Port | int
                }
            }

            // Copy over the labels
            label: spec.label
        }
    }
}
```

The complete top-level model definitions can be found at
[doc/tutorial/kubernetes/manual/services/cloud.cue](https://cue.googlesource.com/cue/+/master/doc/tutorial/kubernetes/manual/services/cloud.cue).

The tailorings for this specific project (the labels) are defined
[here](https://cue.googlesource.com/cue/+/master/doc/tutorial/kubernetes/manual/services/kube.cue).


### Converting to Kubernetes

Converting services is fairly straightforward.

```
kubernetes: services: {
    for k, x in service {
        "\(k)": x.kubernetes & {
            apiVersion: "v1"
            kind:       "Service"

            metadata: name:   x.name
            metadata: labels: x.label
            spec: selector:   x.label

            spec: ports: [ for p in x.port { p } ]
        }
    }
}
```

We add the Kubernetes boilerplate, map the top-level fields and mix in
the raw `kubernetes` fields for each service.

Mapping deployments is a bit more involved, though analogous.
The complete definitions for Kubernetes conversions can be found at
[doc/tutorial/kubernetes/manual/services/k8s.cue](https://cue.googlesource.com/cue/+/master/doc/tutorial/kubernetes/manual/services/k8s.cue).

Converting the top-level definitions to concrete Kubernetes code is the hardest
part of this exercise.
That said, most CUE users will never have to resort to this level of CUE
to write configurations.
For instance, none of the files in the subdirectories contain comprehensions,
not even the template files in these directories (such as `kitchen/kube.cue`).
Furthermore, none of the configuration files in any of the
leaf directories contain string interpolations.


### Metrics

The fully written out manual configuration can be found in the `manual`
subdirectory.
Running our usual count yields
```
$ find . | grep kube.cue | xargs wc | tail -1
     542    1190   11520 total
```
This does not count our conversion templates.
Assuming that the top-level templates are reusable, and if we don't count them
for both approaches, the manual approach shaves off about another 150 lines.
If we count the templates as well, the two approaches are roughly equal.


### Conclusions Manual Configuration

We have shown that we can further compact a configuration by manually
optimizing template files.
However, we have also shown that the manual optimization only gives
a marginal benefit with respect to the quick-and-dirty semi-automatic reduction.
The benefits for the manual definition largely lies in the organizational
flexibility one gets.

Manually tailoring your configurations allows creating an abstraction layer
between logical definitions and Kubernetes-specific definitions.
At the same time, CUE's order independence
makes it easy to mix in low-level Kubernetes configuration wherever it is
convenient and applicable.

Manual tailoring also allows us to add our own definitions without breaking
Kubernetes.
This is crucial in defining information relevant to definitions,
but unrelated to Kubernetes, where they belong.

Separating abstract from concrete configuration also allows us to create
difference adaptors for the same configuration.


<!-- TODO:
## Conversion to `docker-compose`
-->
<script>let pageGuide="2021-03-10-kubernetes-tutorial"; let pageLanguage="en"; let pageScenario="go115";</script>
