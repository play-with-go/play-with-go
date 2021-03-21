package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/cue-kubernetes-tutorial"
		}
	}
}]
Scenarios: [{
	Name:        "go115"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	k3d_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "k3d_init"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "k3d cluster delete hello"
			ExitCode: 0
			Output: """
				\u001b[36mINFO\u001b[0m[0001] Deleting cluster 'hello'                     
				\u001b[36mINFO\u001b[0m[0001] Deleted k3d-hello-serverlb                   
				\u001b[36mINFO\u001b[0m[0001] Deleted k3d-hello-server-0                   
				\u001b[36mINFO\u001b[0m[0001] Deleting cluster network 'k3d-hello'         
				\u001b[36mINFO\u001b[0m[0002] Deleting image volume 'k3d-hello-images'     
				\u001b[36mINFO\u001b[0m[0002] Removing cluster details from default kubeconfig... 
				\u001b[33mWARN\u001b[0m[0002] Failed to remove cluster details from default kubeconfig 
				\u001b[33mWARN\u001b[0m[0002] open /home/gopher/.kube/config: no such file or directory 
				\u001b[36mINFO\u001b[0m[0002] Removing standalone kubeconfig file (if there is one)... 
				\u001b[36mINFO\u001b[0m[0002] Successfully deleted cluster hello!          

				"""
			ComparisonOutput: """
				\u001b[36mINFO\u001b[0m[0001] Deleting cluster 'hello'                     
				\u001b[36mINFO\u001b[0m[0001] Deleted k3d-hello-serverlb                   
				\u001b[36mINFO\u001b[0m[0001] Deleted k3d-hello-server-0                   
				\u001b[36mINFO\u001b[0m[0001] Deleting cluster network 'k3d-hello'         
				\u001b[36mINFO\u001b[0m[0002] Deleting image volume 'k3d-hello-images'     
				\u001b[36mINFO\u001b[0m[0002] Removing cluster details from default kubeconfig... 
				\u001b[33mWARN\u001b[0m[0002] Failed to remove cluster details from default kubeconfig 
				\u001b[33mWARN\u001b[0m[0002] open /home/gopher/.kube/config: no such file or directory 
				\u001b[36mINFO\u001b[0m[0002] Removing standalone kubeconfig file (if there is one)... 
				\u001b[36mINFO\u001b[0m[0002] Successfully deleted cluster hello!          

				"""
		}, {
			Negated:  false
			CmdStr:   "k3d cluster create hello"
			ExitCode: 0
			Output: """
				\u001b[36mINFO\u001b[0m[0000] Prep: Network                                
				\u001b[36mINFO\u001b[0m[0000] Created network 'k3d-hello' (b28f5b5ee656219d759e285b307c9030c2749b43dd11e9ae7046553bf79a2ad9) 
				\u001b[36mINFO\u001b[0m[0000] Created volume 'k3d-hello-images'            
				\u001b[36mINFO\u001b[0m[0001] Creating node 'k3d-hello-server-0'           
				\u001b[36mINFO\u001b[0m[0001] Creating LoadBalancer 'k3d-hello-serverlb'   
				\u001b[36mINFO\u001b[0m[0001] Starting cluster 'hello'                     
				\u001b[36mINFO\u001b[0m[0001] Starting servers...                          
				\u001b[36mINFO\u001b[0m[0001] Starting Node 'k3d-hello-server-0'           
				\u001b[36mINFO\u001b[0m[0007] Starting agents...                           
				\u001b[36mINFO\u001b[0m[0007] Starting helpers...                          
				\u001b[36mINFO\u001b[0m[0007] Starting Node 'k3d-hello-serverlb'           
				\u001b[36mINFO\u001b[0m[0007] (Optional) Trying to get IP of the docker host and inject it into the cluster as 'host.k3d.internal' for easy access 
				\u001b[36mINFO\u001b[0m[0010] Successfully added host record to /etc/hosts in 2/2 nodes and to the CoreDNS ConfigMap 
				\u001b[36mINFO\u001b[0m[0010] Cluster 'hello' created successfully!        
				\u001b[36mINFO\u001b[0m[0010] --kubeconfig-update-default=false --> sets --kubeconfig-switch-context=false 
				\u001b[36mINFO\u001b[0m[0011] You can now use it like this:                
				kubectl config use-context k3d-hello
				kubectl cluster-info

				"""
			ComparisonOutput: """
				\u001b[36mINFO\u001b[0m[0000] Prep: Network                                
				\u001b[36mINFO\u001b[0m[0000] Created network 'k3d-hello' (b28f5b5ee656219d759e285b307c9030c2749b43dd11e9ae7046553bf79a2ad9) 
				\u001b[36mINFO\u001b[0m[0000] Created volume 'k3d-hello-images'            
				\u001b[36mINFO\u001b[0m[0001] Creating node 'k3d-hello-server-0'           
				\u001b[36mINFO\u001b[0m[0001] Creating LoadBalancer 'k3d-hello-serverlb'   
				\u001b[36mINFO\u001b[0m[0001] Starting cluster 'hello'                     
				\u001b[36mINFO\u001b[0m[0001] Starting servers...                          
				\u001b[36mINFO\u001b[0m[0001] Starting Node 'k3d-hello-server-0'           
				\u001b[36mINFO\u001b[0m[0007] Starting agents...                           
				\u001b[36mINFO\u001b[0m[0007] Starting helpers...                          
				\u001b[36mINFO\u001b[0m[0007] Starting Node 'k3d-hello-serverlb'           
				\u001b[36mINFO\u001b[0m[0007] (Optional) Trying to get IP of the docker host and inject it into the cluster as 'host.k3d.internal' for easy access 
				\u001b[36mINFO\u001b[0m[0010] Successfully added host record to /etc/hosts in 2/2 nodes and to the CoreDNS ConfigMap 
				\u001b[36mINFO\u001b[0m[0010] Cluster 'hello' created successfully!        
				\u001b[36mINFO\u001b[0m[0010] --kubeconfig-update-default=false --> sets --kubeconfig-switch-context=false 
				\u001b[36mINFO\u001b[0m[0011] You can now use it like this:                
				kubectl config use-context k3d-hello
				kubectl cluster-info

				"""
		}]
	}
	cue_version: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_version"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue version"
			ExitCode: 0
			Output: """
				cue version v0.4.0 linux/amd64

				"""
			ComparisonOutput: """
				cue version v0.4.0 linux/amd64

				"""
		}]
	}
	clone_cue: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "clone_cue"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git clone -q https://cue.googlesource.com/cue"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd cue"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git checkout -q f014c14c97b13a40f0c85e18843f71a6ce0c1d22"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/cue/doc/tutorial/kubernetes"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	original_tree: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "original_tree"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "tree ./original | head"
			ExitCode: 0
			Output: """
				/scripts/script.sh: line 92: tree: command not found

				"""
			ComparisonOutput: """
				/scripts/script.sh: line 92: tree: command not found

				"""
		}]
	}
	cp_original: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cp_original"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cp -a original tmp"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd tmp"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cue_mod_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_mod_init"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue mod init"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	try_import_1: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "try_import_1"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd services"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  true
			CmdStr:   "cue import ./..."
			ExitCode: 1
			Output: """
				path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml

				"""
			ComparisonOutput: """
				path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml

				"""
		}]
	}
	try_import_2: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "try_import_2"
		Order:           7
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "cue import ./... -p kube"
			ExitCode: 1
			Output: """
				path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml

				"""
			ComparisonOutput: """
				path, list, or files flag needed to handle multiple objects in file ./services/frontend/bartender/kube.yaml

				"""
		}]
	}
	import_success: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "import_success"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue import ./... -p kube -l 'strings.ToCamel(kind)' -l metadata.name -f"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	tree_head_post_import: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "tree_head_post_import"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "tree . | head"
			ExitCode: 0
			Output: """
				/scripts/script.sh: line 188: tree: command not found

				"""
			ComparisonOutput: """
				/scripts/script.sh: line 188: tree: command not found

				"""
		}]
	}
	cat_configmap: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cat_configmap"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat mon/prometheus/configmap.cue | head"
			ExitCode: 0
			Output: #"""
				package kube

				configMap: prometheus: {
				\#tapiVersion: "v1"
				\#tkind:       "ConfigMap"
				\#tmetadata: name: "prometheus"
				\#tdata: {
				\#t\#t"alert.rules": """
				\#t\#t\#tgroups:
				\#t\#t\#t- name: rules.yaml

				"""#
			ComparisonOutput: #"""
				package kube

				configMap: prometheus: {
				\#tapiVersion: "v1"
				\#tkind:       "ConfigMap"
				\#tmetadata: name: "prometheus"
				\#tdata: {
				\#t\#t"alert.rules": """
				\#t\#t\#tgroups:
				\#t\#t\#t- name: rules.yaml

				"""#
		}]
	}
	import_recursive: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "import_recursive"
		Order:           11
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue import ./... -p kube -l 'strings.ToCamel(kind)' -l metadata.name -f -R"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cat_configmap_post_recursive_import: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cat_configmap_post_recursive_import"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat mon/prometheus/configmap.cue | head"
			ExitCode: 0
			Output: """
				package kube

				import yaml656e63 "encoding/yaml"

				configMap: prometheus: {
				\tapiVersion: "v1"
				\tkind:       "ConfigMap"
				\tmetadata: name: "prometheus"
				\tdata: {
				\t\t"alert.rules": yaml656e63.Marshal(_cue_alert_rules)

				"""
			ComparisonOutput: """
				package kube

				import yaml656e63 "encoding/yaml"

				configMap: prometheus: {
				\tapiVersion: "v1"
				\tkind:       "ConfigMap"
				\tmetadata: name: "prometheus"
				\tdata: {
				\t\t"alert.rules": yaml656e63.Marshal(_cue_alert_rules)

				"""
		}]
	}
	cue_eval_configmap_prometheus: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_eval_configmap_prometheus"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue eval ./mon/prometheus -e configMap.prometheus"
			ExitCode: 0
			Output: #"""
				apiVersion: "v1"
				kind:       "ConfigMap"
				metadata: {
				    name: "prometheus"
				}
				data: {
				    "alert.rules": """
				        groups:
				        - name: rules.yaml
				          rules:
				          - alert: InstanceDown
				            expr: up == 0
				            for: 30s
				            labels:
				              severity: page
				            annotations:
				              description: '{{$labels.app}} of job {{ $labels.job }} has been down for more
				                than 30 seconds.'
				              summary: Instance {{$labels.app}} down
				          - alert: InsufficientPeers
				            expr: count(up{job="etcd"} == 0) > (count(up{job="etcd"}) / 2 - 1)
				            for: 3m
				            labels:
				              severity: page
				            annotations:
				              description: If one more etcd peer goes down the cluster will be unavailable
				              summary: etcd cluster small
				          - alert: EtcdNoMaster
				            expr: sum(etcd_server_has_leader{app="etcd"}) == 0
				            for: 1s
				            labels:
				              severity: page
				            annotations:
				              summary: No ETCD master elected.
				          - alert: PodRestart
				            expr: (max_over_time(pod_container_status_restarts_total[5m]) - min_over_time(pod_container_status_restarts_total[5m]))
				              > 2
				            for: 1m
				            labels:
				              severity: page
				            annotations:
				              description: '{{$labels.app}} {{ $labels.container }} resturted {{ $value }}
				                times in 5m.'
				              summary: Pod for {{$labels.container}} restarts too often

				        """
				    "prometheus.yml": """
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
				            replacement: /api/v1/nodes/${1}/proxy/metrics
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
				            replacement: /api/v1/nodes/${1}/proxy/metrics/cadvisor
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
				            regex: ([^:]+)(?::\#\\#\d+)?;(\#\\#\d+)
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
				            replacement: ${1}://${2}${3}
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
				            regex: ([^:]+)(?::\#\\#\d+)?;(\#\\#\d+)
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

				        """
				}

				"""#
			ComparisonOutput: #"""
				apiVersion: "v1"
				kind:       "ConfigMap"
				metadata: {
				    name: "prometheus"
				}
				data: {
				    "alert.rules": """
				        groups:
				        - name: rules.yaml
				          rules:
				          - alert: InstanceDown
				            expr: up == 0
				            for: 30s
				            labels:
				              severity: page
				            annotations:
				              description: '{{$labels.app}} of job {{ $labels.job }} has been down for more
				                than 30 seconds.'
				              summary: Instance {{$labels.app}} down
				          - alert: InsufficientPeers
				            expr: count(up{job="etcd"} == 0) > (count(up{job="etcd"}) / 2 - 1)
				            for: 3m
				            labels:
				              severity: page
				            annotations:
				              description: If one more etcd peer goes down the cluster will be unavailable
				              summary: etcd cluster small
				          - alert: EtcdNoMaster
				            expr: sum(etcd_server_has_leader{app="etcd"}) == 0
				            for: 1s
				            labels:
				              severity: page
				            annotations:
				              summary: No ETCD master elected.
				          - alert: PodRestart
				            expr: (max_over_time(pod_container_status_restarts_total[5m]) - min_over_time(pod_container_status_restarts_total[5m]))
				              > 2
				            for: 1m
				            labels:
				              severity: page
				            annotations:
				              description: '{{$labels.app}} {{ $labels.container }} resturted {{ $value }}
				                times in 5m.'
				              summary: Pod for {{$labels.container}} restarts too often

				        """
				    "prometheus.yml": """
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
				            replacement: /api/v1/nodes/${1}/proxy/metrics
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
				            replacement: /api/v1/nodes/${1}/proxy/metrics/cadvisor
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
				            regex: ([^:]+)(?::\#\\#\d+)?;(\#\\#\d+)
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
				            replacement: ${1}://${2}${3}
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
				            regex: ([^:]+)(?::\#\\#\d+)?;(\#\\#\d+)
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

				        """
				}

				"""#
		}]
	}
	cue_eval_snapshot1: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_eval_snapshot1"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue eval -c ./... >snapshot"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cp_breaddispatcher: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cp_breaddispatcher"
		Order:           15
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cp frontend/breaddispatcher/kube.cue ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	upload_kube: {
		StepType: 2
		Name:     "upload_kube"
		Order:    16
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package kube

			service: [ID=_]: {
			\tapiVersion: "v1"
			\tkind:       "Service"
			\tmetadata: {
			\t\tname: ID
			\t\tlabels: {
			\t\t\tapp:       ID     // by convention
			\t\t\tdomain:    "prod" // always the same in the given files
			\t\t\tcomponent: string // varies per directory
			\t\t}
			\t}
			\tspec: {
			\t\t// Any port has the following properties.
			\t\tports: [...{
			\t\t\tport:     int
			\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
			\t\t\tname:     string | *"client"
			\t\t}]
			\t\tselector: metadata.labels // we want those to be the same
			\t}
			}

			deployment: [ID=_]: {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\tmetadata: name: ID
			\tspec: {
			\t\t// 1 is the default, but we allow any number
			\t\treplicas: *1 | int
			\t\ttemplate: {
			\t\t\tmetadata: labels: {
			\t\t\t\tapp:       ID
			\t\t\t\tdomain:    "prod"
			\t\t\t\tcomponent: string
			\t\t\t}
			\t\t\t// we always have one namesake container
			\t\t\tspec: containers: [{name: ID}]
			\t\t}
			\t}
			}

			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/kube.cue"
	}
	cue_eval_snapshot_bad: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_eval_snapshot_bad"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "cue eval -c ./... >snapshot2"
			ExitCode: 1
			Output: """
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/alertmanager
				deployment.alertmanager.spec.template.metadata.labels.component: incomplete value string
				service.alertmanager.metadata.labels.component: incomplete value string
				service.alertmanager.spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/nodeexporter
				service."node-exporter".metadata.labels.component: incomplete value string
				service."node-exporter".spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/prometheus
				deployment.prometheus.spec.template.metadata.labels.component: incomplete value string
				service.prometheus.metadata.labels.component: incomplete value string
				service.prometheus.spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/proxy/authproxy
				deployment.authproxy.spec.template.metadata.labels.component: incomplete value string
				service.authproxy.metadata.labels.component: incomplete value string
				service.authproxy.spec.selector.component: incomplete value string

				"""
			ComparisonOutput: """
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/alertmanager
				deployment.alertmanager.spec.template.metadata.labels.component: incomplete value string
				service.alertmanager.metadata.labels.component: incomplete value string
				service.alertmanager.spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/nodeexporter
				service."node-exporter".metadata.labels.component: incomplete value string
				service."node-exporter".spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/mon/prometheus
				deployment.prometheus.spec.template.metadata.labels.component: incomplete value string
				service.prometheus.metadata.labels.component: incomplete value string
				service.prometheus.spec.selector.component: incomplete value string
				// /home/gopher/cue/doc/tutorial/kubernetes/tmp/services/proxy/authproxy
				deployment.authproxy.spec.template.metadata.labels.component: incomplete value string
				service.authproxy.metadata.labels.component: incomplete value string
				service.authproxy.spec.selector.component: incomplete value string

				"""
		}]
	}
	add_field_previous_template_def: {
		StepType: 2
		Name:     "add_field_previous_template_def"
		Order:    18
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 3
			Pre: """
				package kube

				service: [ID=_]: {
				\tapiVersion: "v1"
				\tkind:       "Service"
				\tmetadata: {
				\t\tname: ID
				\t\tlabels: {
				\t\t\tapp:       ID     // by convention
				\t\t\tdomain:    "prod" // always the same in the given files
				\t\t\tcomponent: string // varies per directory
				\t\t}
				\t}
				\tspec: {
				\t\t// Any port has the following properties.
				\t\tports: [...{
				\t\t\tport:     int
				\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
				\t\t\tname:     string | *"client"
				\t\t}]
				\t\tselector: metadata.labels // we want those to be the same
				\t}
				}

				deployment: [ID=_]: {
				\tapiVersion: "apps/v1"
				\tkind:       "Deployment"
				\tmetadata: name: ID
				\tspec: {
				\t\t// 1 is the default, but we allow any number
				\t\treplicas: *1 | int
				\t\ttemplate: {
				\t\t\tmetadata: labels: {
				\t\t\t\tapp:       ID
				\t\t\t\tdomain:    "prod"
				\t\t\t\tcomponent: string
				\t\t\t}
				\t\t\t// we always have one namesake container
				\t\t\tspec: containers: [{name: ID}]
				\t\t}
				\t}
				}

				"""
		}
		Source: """
			package kube

			service: [ID=_]: {
			\tapiVersion: "v1"
			\tkind:       "Service"
			\tmetadata: {
			\t\tname: ID
			\t\tlabels: {
			\t\t\tapp:       ID         // by convention
			\t\t\tdomain:    "prod"     // always the same in the given files
			\t\t\tcomponent: #Component // varies per directory
			\t\t}
			\t}
			\tspec: {
			\t\t// Any port has the following properties.
			\t\tports: [...{
			\t\t\tport:     int
			\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
			\t\t\tname:     string | *"client"
			\t\t}]
			\t\tselector: metadata.labels // we want those to be the same
			\t}
			}

			deployment: [ID=_]: {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\tmetadata: name: ID
			\tspec: {
			\t\t// 1 is the default, but we allow any number
			\t\treplicas: *1 | int
			\t\ttemplate: {
			\t\t\tmetadata: labels: {
			\t\t\t\tapp:       ID
			\t\t\t\tdomain:    "prod"
			\t\t\t\tcomponent: #Component
			\t\t\t}
			\t\t\t// we always have one namesake container
			\t\t\tspec: containers: [{name: ID}]
			\t\t}
			\t}
			}

			#Component: string

			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/kube.cue"
	}
	add_file_component_label_each_dir: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "add_file_component_label_each_dir"
		Order:           19
		Terminal:        "term1"
		Stmts: [{
			Negated: false
			CmdStr: """
				ls -d */ | sed 's/.$//' | xargs -I DIR sh -c 'cd DIR; echo "package kube

				#Component: \\"DIR\\"
				" > kube.cue; cd ..'
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	format_the_files: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "format_the_files"
		Order:           20
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue fmt kube.cue */kube.cue"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cue_eval_snapshot2: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_eval_snapshot2"
		Order:           21
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue eval -c ./... >snapshot2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  true
			CmdStr:   "diff -wu snapshot snapshot2"
			ExitCode: 1
			Output: #"""
				--- snapshot\#t2021-05-28 16:42:09.018725443 +0000
				+++ snapshot2\#t2021-05-28 16:42:14.178579100 +0000
				@@ -1,3 +1,9 @@
				+service: {}
				+deployment: {}
				+// ---
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     bartender: {
				         apiVersion: "v1"
				@@ -208,6 +214,7 @@
				             selector: {
				                 app:    "maitred"
				                 domain: "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -270,6 +277,7 @@
				             selector: {
				                 app:    "valeter"
				                 domain: "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -330,6 +338,8 @@
				             }]
				             selector: {
				                 app: "waiter"
				+                component: "frontend"
				+                domain:    "prod"
				             }
				         }
				     }
				@@ -432,6 +442,9 @@
				     }
				 }
				 // ---
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     download: {
				         apiVersion: "v1"
				@@ -454,6 +467,7 @@
				             selector: {
				                 app:    "download"
				                 domain: "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -497,6 +511,7 @@
				             name: "etcd"
				             labels: {
				                 app:       "etcd"
				+                domain:    "prod"
				                 component: "infra"
				             }
				         }
				@@ -504,6 +519,8 @@
				             clusterIP: "None"
				             selector: {
				                 app: "etcd"
				+                domain:    "prod"
				+                component: "infra"
				             }
				             ports: [{
				                 port:       2379
				@@ -519,6 +536,7 @@
				         }
				     }
				 }
				+deployment: {}
				 statefulSet: {
				     etcd: {
				         apiVersion: "apps/v1"
				@@ -712,6 +730,35 @@
				     }
				 }
				 // ---
				+service: {
				+    tasks: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "tasks"
				+            labels: {
				+                app:       "tasks"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				+        }
				+        spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.2.3.4"
				+            ports: [{
				+                port:       443
				+                targetPort: 7443
				+                protocol:   "TCP"
				+                name:       "http"
				+            }]
				+            selector: {
				+                app:       "tasks"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				+        }
				+    }
				+}
				 deployment: {
				     tasks: {
				         apiVersion: "apps/v1"
				@@ -725,6 +772,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "tasks"
				+                        domain:    "prod"
				                         component: "infra"
				                     }
				                     annotations: {
				@@ -757,32 +805,6 @@
				         }
				     }
				 }
				-service: {
				-    tasks: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "tasks"
				-            labels: {
				-                app:       "tasks"
				-                component: "infra"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.2.3.4"
				-            ports: [{
				-                port:       443
				-                targetPort: 7443
				-                protocol:   "TCP"
				-                name:       "http"
				-            }]
				-            selector: {
				-                app: "tasks"
				-            }
				-        }
				-    }
				-}
				 // ---
				 service: {
				     updater: {
				@@ -806,6 +828,7 @@
				             selector: {
				                 app:    "updater"
				                 domain: "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -852,6 +875,35 @@
				     }
				 }
				 // ---
				+service: {
				+    watcher: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "watcher"
				+            labels: {
				+                app:       "watcher"
				+                component: "infra"
				+                domain:    "prod"
				+            }
				+        }
				+        spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.2.3.4."
				+            ports: [{
				+                port:       7788
				+                targetPort: 7788
				+                protocol:   "TCP"
				+                name:       "http"
				+            }]
				+            selector: {
				+                app:       "watcher"
				+                component: "infra"
				+                domain:    "prod"
				+            }
				+        }
				+    }
				+}
				 deployment: {
				     watcher: {
				         apiVersion: "apps/v1"
				@@ -894,33 +946,9 @@
				         }
				     }
				 }
				-service: {
				-    watcher: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "watcher"
				-            labels: {
				-                app:       "watcher"
				-                component: "infra"
				-                domain:    "prod"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.2.3.4."
				-            ports: [{
				-                port:       7788
				-                targetPort: 7788
				-                protocol:   "TCP"
				-                name:       "http"
				-            }]
				-            selector: {
				-                app: "watcher"
				-            }
				-        }
				-    }
				-}
				+// ---
				+service: {}
				+deployment: {}
				 // ---
				 service: {
				     caller: {
				@@ -944,6 +972,7 @@
				             selector: {
				                 app:    "caller"
				                 domain: "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1500,6 +1529,8 @@
				             }]
				             selector: {
				                 app: "souschef"
				+                component: "kitchen"
				+                domain:    "prod"
				             }
				         }
				     }
				@@ -1543,33 +1574,9 @@
				     }
				 }
				 // ---
				-configMap: {
				-    alertmanager: {
				-        apiVersion: "v1"
				-        kind:       "ConfigMap"
				-        metadata: {
				-            name: "alertmanager"
				-        }
				-        data: {
				-            "alerts.yaml": """
				-                receivers:
				-                - name: pager
				-                  slack_configs:
				-                  - channel: '#cloudmon'
				-                    text: |-
				-                      {{ range .Alerts }}{{ .Annotations.description }}
				-                      {{ end }}
				-                    send_resolved: true
				-                route:
				-                  receiver: pager
				-                  group_by:
				-                  - alertname
				-                  - cluster
				-
				-                """
				-        }
				-    }
				-}
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     alertmanager: {
				         apiVersion: "v1"
				@@ -1581,12 +1588,18 @@
				             }
				             labels: {
				                 name: "alertmanager"
				+                app:       "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             name: "alertmanager"
				         }
				         spec: {
				             selector: {
				                 app: "alertmanager"
				+                name:      "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             ports: [{
				                 name:       "main"
				@@ -1597,6 +1610,33 @@
				         }
				     }
				 }
				+configMap: {
				+    alertmanager: {
				+        apiVersion: "v1"
				+        kind:       "ConfigMap"
				+        metadata: {
				+            name: "alertmanager"
				+        }
				+        data: {
				+            "alerts.yaml": """
				+                receivers:
				+                - name: pager
				+                  slack_configs:
				+                  - channel: '#cloudmon'
				+                    text: |-
				+                      {{ range .Alerts }}{{ .Annotations.description }}
				+                      {{ end }}
				+                    send_resolved: true
				+                route:
				+                  receiver: pager
				+                  group_by:
				+                  - alertname
				+                  - cluster
				+
				+                """
				+        }
				+    }
				+}
				 deployment: {
				     alertmanager: {
				         apiVersion: "apps/v1"
				@@ -1616,6 +1656,8 @@
				                     name: "alertmanager"
				                     labels: {
				                         app: "alertmanager"
				+                        domain:    "prod"
				+                        component: "mon"
				                     }
				                 }
				                 spec: {
				@@ -1650,6 +1692,33 @@
				     }
				 }
				 // ---
				+service: {
				+    grafana: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "grafana"
				+            labels: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+        }
				+        spec: {
				+            selector: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            ports: [{
				+                name:       "grafana"
				+                protocol:   "TCP"
				+                port:       3000
				+                targetPort: 3000
				+            }]
				+        }
				+    }
				+}
				 deployment: {
				     grafana: {
				         apiVersion: "apps/v1"
				@@ -1667,6 +1736,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "grafana"
				+                        domain:    "prod"
				                         component: "mon"
				                     }
				                 }
				@@ -1714,31 +1784,6 @@
				         }
				     }
				 }
				-service: {
				-    grafana: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "grafana"
				-            labels: {
				-                app:       "grafana"
				-                component: "mon"
				-            }
				-        }
				-        spec: {
				-            selector: {
				-                app:       "grafana"
				-                component: "mon"
				-            }
				-            ports: [{
				-                name:       "grafana"
				-                protocol:   "TCP"
				-                port:       3000
				-                targetPort: 3000
				-            }]
				-        }
				-    }
				-}
				 // ---
				 service: {
				     "node-exporter": {
				@@ -1747,6 +1792,8 @@
				         metadata: {
				             labels: {
				                 app: "node-exporter"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             annotations: {
				                 "prometheus.io/scrape": "true"
				@@ -1763,10 +1810,13 @@
				             }]
				             selector: {
				                 app: "node-exporter"
				+                domain:    "prod"
				+                component: "mon"
				             }
				         }
				     }
				 }
				+deployment: {}
				 daemonSet: {
				     "node-exporter": {
				         apiVersion: "apps/v1"
				@@ -1831,6 +1881,39 @@
				     }
				 }
				 // ---
				+service: {
				+    prometheus: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            annotations: {
				+                "prometheus.io/scrape": "true"
				+            }
				+            labels: {
				+                name:      "prometheus"
				+                app:       "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            name: "prometheus"
				+        }
				+        spec: {
				+            selector: {
				+                app:       "prometheus"
				+                name:      "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            type: "NodePort"
				+            ports: [{
				+                name:     "main"
				+                protocol: "TCP"
				+                port:     9090
				+                nodePort: 30900
				+            }]
				+        }
				+    }
				+}
				 configMap: {
				     prometheus: {
				         apiVersion: "v1"
				@@ -2069,33 +2152,6 @@
				         }
				     }
				 }
				-service: {
				-    prometheus: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            annotations: {
				-                "prometheus.io/scrape": "true"
				-            }
				-            labels: {
				-                name: "prometheus"
				-            }
				-            name: "prometheus"
				-        }
				-        spec: {
				-            selector: {
				-                app: "prometheus"
				-            }
				-            type: "NodePort"
				-            ports: [{
				-                name:     "main"
				-                protocol: "TCP"
				-                port:     9090
				-                nodePort: 30900
				-            }]
				-        }
				-    }
				-}
				 deployment: {
				     prometheus: {
				         apiVersion: "apps/v1"
				@@ -2122,6 +2178,8 @@
				                     name: "prometheus"
				                     labels: {
				                         app: "prometheus"
				+                        domain:    "prod"
				+                        component: "mon"
				                     }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				@@ -2153,6 +2211,77 @@
				     }
				 }
				 // ---
				+service: {}
				+deployment: {}
				+// ---
				+service: {
				+    authproxy: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                app:       "authproxy"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+        spec: {
				+            ports: [{
				+                port:       4180
				+                targetPort: 4180
				+                protocol:   "TCP"
				+                name:       "client"
				+            }]
				+            selector: {
				+                app:       "authproxy"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+    }
				+}
				+deployment: {
				+    authproxy: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				+        metadata: {
				+            name: "authproxy"
				+        }
				+        spec: {
				+            replicas: 1
				+            template: {
				+                metadata: {
				+                    labels: {
				+                        app:       "authproxy"
				+                        domain:    "prod"
				+                        component: "proxy"
				+                    }
				+                }
				+                spec: {
				+                    containers: [{
				+                        name:  "authproxy"
				+                        image: "skippy/oauth2_proxy:2.0.1"
				+                        ports: [{
				+                            containerPort: 4180
				+                        }]
				+                        args: ["--config=/etc/authproxy/authproxy.cfg"]
				+                        volumeMounts: [{
				+                            name:      "config-volume"
				+                            mountPath: "/etc/authproxy"
				+                        }]
				+                    }]
				+                    volumes: [{
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "authproxy"
				+                        }
				+                    }]
				+                }
				+            }
				+        }
				+    }
				+}
				 configMap: {
				     authproxy: {
				         apiVersion: "v1"
				@@ -2217,71 +2346,36 @@
				         }
				     }
				 }
				-deployment: {
				-    authproxy: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "authproxy"
				-        }
				-        spec: {
				-            replicas: 1
				-            template: {
				-                metadata: {
				-                    labels: {
				-                        app:    "authproxy"
				-                        domain: "prod"
				-                    }
				-                }
				-                spec: {
				-                    containers: [{
				-                        name:  "authproxy"
				-                        image: "skippy/oauth2_proxy:2.0.1"
				-                        ports: [{
				-                            containerPort: 4180
				-                        }]
				-                        args: ["--config=/etc/authproxy/authproxy.cfg"]
				-                        volumeMounts: [{
				-                            name:      "config-volume"
				-                            mountPath: "/etc/authproxy"
				-                        }]
				-                    }]
				-                    volumes: [{
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "authproxy"
				-                        }
				-                    }]
				-                }
				-            }
				-        }
				-    }
				-}
				+// ---
				 service: {
				-    authproxy: {
				+    goget: {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				-            name: "authproxy"
				+            name: "goget"
				             labels: {
				-                app:    "authproxy"
				+                app:       "goget"
				                 domain: "prod"
				+                component: "proxy"
				             }
				         }
				         spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.3.5.7"
				             ports: [{
				-                port:       4180
				-                targetPort: 4180
				+                port:       443
				+                targetPort: 7443
				                 protocol:   "TCP"
				-                name:       "client"
				+                name:       "https"
				             }]
				             selector: {
				-                app: "authproxy"
				+                app:       "goget"
				+                domain:    "prod"
				+                component: "proxy"
				             }
				         }
				     }
				 }
				-// ---
				 deployment: {
				     goget: {
				         apiVersion: "apps/v1"
				@@ -2295,6 +2389,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "goget"
				+                        domain:    "prod"
				                         component: "proxy"
				                     }
				                 }
				@@ -2321,33 +2416,91 @@
				         }
				     }
				 }
				+// ---
				 service: {
				-    goget: {
				+    nginx: {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				-            name: "goget"
				+            name: "nginx"
				             labels: {
				-                app:       "goget"
				+                app:       "nginx"
				+                domain:    "prod"
				                 component: "proxy"
				             }
				         }
				         spec: {
				             type:           "LoadBalancer"
				-            loadBalancerIP: "1.3.5.7"
				+            loadBalancerIP: "1.3.4.5"
				             ports: [{
				+                port:       80
				+                targetPort: 80
				+                protocol:   "TCP"
				+                name:       "http"
				+            }, {
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "https"
				             }]
				             selector: {
				-                app: "goget"
				+                app:       "nginx"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+    }
				+}
				+deployment: {
				+    nginx: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				+        metadata: {
				+            name: "nginx"
				+        }
				+        spec: {
				+            replicas: 1
				+            template: {
				+                metadata: {
				+                    labels: {
				+                        app:       "nginx"
				+                        domain:    "prod"
				+                        component: "proxy"
				+                    }
				+                }
				+                spec: {
				+                    volumes: [{
				+                        name: "secret-volume"
				+                        secret: {
				+                            secretName: "proxy-secrets"
				+                        }
				+                    }, {
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "nginx"
				+                        }
				+                    }]
				+                    containers: [{
				+                        name:  "nginx"
				+                        image: "nginx:1.11.10-alpine"
				+                        ports: [{
				+                            containerPort: 80
				+                        }, {
				+                            containerPort: 443
				+                        }]
				+                        volumeMounts: [{
				+                            mountPath: "/etc/ssl"
				+                            name:      "secret-volume"
				+                        }, {
				+                            name:      "config-volume"
				+                            mountPath: "/etc/nginx/nginx.conf"
				+                            subPath:   "nginx.conf"
				+                        }]
				+                    }]
				+                }
				             }
				         }
				     }
				 }
				-// ---
				 configMap: {
				     nginx: {
				         apiVersion: "v1"
				@@ -2513,83 +2666,3 @@
				         }
				     }
				 }
				-deployment: {
				-    nginx: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "nginx"
				-        }
				-        spec: {
				-            replicas: 1
				-            template: {
				-                metadata: {
				-                    labels: {
				-                        app:       "nginx"
				-                        component: "proxy"
				-                    }
				-                }
				-                spec: {
				-                    volumes: [{
				-                        name: "secret-volume"
				-                        secret: {
				-                            secretName: "proxy-secrets"
				-                        }
				-                    }, {
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "nginx"
				-                        }
				-                    }]
				-                    containers: [{
				-                        name:  "nginx"
				-                        image: "nginx:1.11.10-alpine"
				-                        ports: [{
				-                            containerPort: 80
				-                        }, {
				-                            containerPort: 443
				-                        }]
				-                        volumeMounts: [{
				-                            mountPath: "/etc/ssl"
				-                            name:      "secret-volume"
				-                        }, {
				-                            name:      "config-volume"
				-                            mountPath: "/etc/nginx/nginx.conf"
				-                            subPath:   "nginx.conf"
				-                        }]
				-                    }]
				-                }
				-            }
				-        }
				-    }
				-}
				-service: {
				-    nginx: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "nginx"
				-            labels: {
				-                app:       "nginx"
				-                component: "proxy"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.3.4.5"
				-            ports: [{
				-                port:       80
				-                targetPort: 80
				-                protocol:   "TCP"
				-                name:       "http"
				-            }, {
				-                port:     443
				-                protocol: "TCP"
				-                name:     "https"
				-            }]
				-            selector: {
				-                app: "nginx"
				-            }
				-        }
				-    }
				-}

				"""#
			ComparisonOutput: #"""
				--- snapshot\#t2021-05-28 16:42:09.018725443 +0000
				+++ snapshot2\#t2021-05-28 16:42:14.178579100 +0000
				@@ -1,3 +1,9 @@
				+service: {}
				+deployment: {}
				+// ---
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     bartender: {
				         apiVersion: "v1"
				@@ -208,6 +214,7 @@
				             selector: {
				                 app:    "maitred"
				                 domain: "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -270,6 +277,7 @@
				             selector: {
				                 app:    "valeter"
				                 domain: "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -330,6 +338,8 @@
				             }]
				             selector: {
				                 app: "waiter"
				+                component: "frontend"
				+                domain:    "prod"
				             }
				         }
				     }
				@@ -432,6 +442,9 @@
				     }
				 }
				 // ---
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     download: {
				         apiVersion: "v1"
				@@ -454,6 +467,7 @@
				             selector: {
				                 app:    "download"
				                 domain: "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -497,6 +511,7 @@
				             name: "etcd"
				             labels: {
				                 app:       "etcd"
				+                domain:    "prod"
				                 component: "infra"
				             }
				         }
				@@ -504,6 +519,8 @@
				             clusterIP: "None"
				             selector: {
				                 app: "etcd"
				+                domain:    "prod"
				+                component: "infra"
				             }
				             ports: [{
				                 port:       2379
				@@ -519,6 +536,7 @@
				         }
				     }
				 }
				+deployment: {}
				 statefulSet: {
				     etcd: {
				         apiVersion: "apps/v1"
				@@ -712,6 +730,35 @@
				     }
				 }
				 // ---
				+service: {
				+    tasks: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "tasks"
				+            labels: {
				+                app:       "tasks"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				+        }
				+        spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.2.3.4"
				+            ports: [{
				+                port:       443
				+                targetPort: 7443
				+                protocol:   "TCP"
				+                name:       "http"
				+            }]
				+            selector: {
				+                app:       "tasks"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				+        }
				+    }
				+}
				 deployment: {
				     tasks: {
				         apiVersion: "apps/v1"
				@@ -725,6 +772,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "tasks"
				+                        domain:    "prod"
				                         component: "infra"
				                     }
				                     annotations: {
				@@ -757,32 +805,6 @@
				         }
				     }
				 }
				-service: {
				-    tasks: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "tasks"
				-            labels: {
				-                app:       "tasks"
				-                component: "infra"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.2.3.4"
				-            ports: [{
				-                port:       443
				-                targetPort: 7443
				-                protocol:   "TCP"
				-                name:       "http"
				-            }]
				-            selector: {
				-                app: "tasks"
				-            }
				-        }
				-    }
				-}
				 // ---
				 service: {
				     updater: {
				@@ -806,6 +828,7 @@
				             selector: {
				                 app:    "updater"
				                 domain: "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -852,6 +875,35 @@
				     }
				 }
				 // ---
				+service: {
				+    watcher: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "watcher"
				+            labels: {
				+                app:       "watcher"
				+                component: "infra"
				+                domain:    "prod"
				+            }
				+        }
				+        spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.2.3.4."
				+            ports: [{
				+                port:       7788
				+                targetPort: 7788
				+                protocol:   "TCP"
				+                name:       "http"
				+            }]
				+            selector: {
				+                app:       "watcher"
				+                component: "infra"
				+                domain:    "prod"
				+            }
				+        }
				+    }
				+}
				 deployment: {
				     watcher: {
				         apiVersion: "apps/v1"
				@@ -894,33 +946,9 @@
				         }
				     }
				 }
				-service: {
				-    watcher: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "watcher"
				-            labels: {
				-                app:       "watcher"
				-                component: "infra"
				-                domain:    "prod"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.2.3.4."
				-            ports: [{
				-                port:       7788
				-                targetPort: 7788
				-                protocol:   "TCP"
				-                name:       "http"
				-            }]
				-            selector: {
				-                app: "watcher"
				-            }
				-        }
				-    }
				-}
				+// ---
				+service: {}
				+deployment: {}
				 // ---
				 service: {
				     caller: {
				@@ -944,6 +972,7 @@
				             selector: {
				                 app:    "caller"
				                 domain: "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1500,6 +1529,8 @@
				             }]
				             selector: {
				                 app: "souschef"
				+                component: "kitchen"
				+                domain:    "prod"
				             }
				         }
				     }
				@@ -1543,33 +1574,9 @@
				     }
				 }
				 // ---
				-configMap: {
				-    alertmanager: {
				-        apiVersion: "v1"
				-        kind:       "ConfigMap"
				-        metadata: {
				-            name: "alertmanager"
				-        }
				-        data: {
				-            "alerts.yaml": """
				-                receivers:
				-                - name: pager
				-                  slack_configs:
				-                  - channel: '#cloudmon'
				-                    text: |-
				-                      {{ range .Alerts }}{{ .Annotations.description }}
				-                      {{ end }}
				-                    send_resolved: true
				-                route:
				-                  receiver: pager
				-                  group_by:
				-                  - alertname
				-                  - cluster
				-
				-                """
				-        }
				-    }
				-}
				+service: {}
				+deployment: {}
				+// ---
				 service: {
				     alertmanager: {
				         apiVersion: "v1"
				@@ -1581,12 +1588,18 @@
				             }
				             labels: {
				                 name: "alertmanager"
				+                app:       "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             name: "alertmanager"
				         }
				         spec: {
				             selector: {
				                 app: "alertmanager"
				+                name:      "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             ports: [{
				                 name:       "main"
				@@ -1597,6 +1610,33 @@
				         }
				     }
				 }
				+configMap: {
				+    alertmanager: {
				+        apiVersion: "v1"
				+        kind:       "ConfigMap"
				+        metadata: {
				+            name: "alertmanager"
				+        }
				+        data: {
				+            "alerts.yaml": """
				+                receivers:
				+                - name: pager
				+                  slack_configs:
				+                  - channel: '#cloudmon'
				+                    text: |-
				+                      {{ range .Alerts }}{{ .Annotations.description }}
				+                      {{ end }}
				+                    send_resolved: true
				+                route:
				+                  receiver: pager
				+                  group_by:
				+                  - alertname
				+                  - cluster
				+
				+                """
				+        }
				+    }
				+}
				 deployment: {
				     alertmanager: {
				         apiVersion: "apps/v1"
				@@ -1616,6 +1656,8 @@
				                     name: "alertmanager"
				                     labels: {
				                         app: "alertmanager"
				+                        domain:    "prod"
				+                        component: "mon"
				                     }
				                 }
				                 spec: {
				@@ -1650,6 +1692,33 @@
				     }
				 }
				 // ---
				+service: {
				+    grafana: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "grafana"
				+            labels: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+        }
				+        spec: {
				+            selector: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            ports: [{
				+                name:       "grafana"
				+                protocol:   "TCP"
				+                port:       3000
				+                targetPort: 3000
				+            }]
				+        }
				+    }
				+}
				 deployment: {
				     grafana: {
				         apiVersion: "apps/v1"
				@@ -1667,6 +1736,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "grafana"
				+                        domain:    "prod"
				                         component: "mon"
				                     }
				                 }
				@@ -1714,31 +1784,6 @@
				         }
				     }
				 }
				-service: {
				-    grafana: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "grafana"
				-            labels: {
				-                app:       "grafana"
				-                component: "mon"
				-            }
				-        }
				-        spec: {
				-            selector: {
				-                app:       "grafana"
				-                component: "mon"
				-            }
				-            ports: [{
				-                name:       "grafana"
				-                protocol:   "TCP"
				-                port:       3000
				-                targetPort: 3000
				-            }]
				-        }
				-    }
				-}
				 // ---
				 service: {
				     "node-exporter": {
				@@ -1747,6 +1792,8 @@
				         metadata: {
				             labels: {
				                 app: "node-exporter"
				+                domain:    "prod"
				+                component: "mon"
				             }
				             annotations: {
				                 "prometheus.io/scrape": "true"
				@@ -1763,10 +1810,13 @@
				             }]
				             selector: {
				                 app: "node-exporter"
				+                domain:    "prod"
				+                component: "mon"
				             }
				         }
				     }
				 }
				+deployment: {}
				 daemonSet: {
				     "node-exporter": {
				         apiVersion: "apps/v1"
				@@ -1831,6 +1881,39 @@
				     }
				 }
				 // ---
				+service: {
				+    prometheus: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            annotations: {
				+                "prometheus.io/scrape": "true"
				+            }
				+            labels: {
				+                name:      "prometheus"
				+                app:       "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            name: "prometheus"
				+        }
				+        spec: {
				+            selector: {
				+                app:       "prometheus"
				+                name:      "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+            type: "NodePort"
				+            ports: [{
				+                name:     "main"
				+                protocol: "TCP"
				+                port:     9090
				+                nodePort: 30900
				+            }]
				+        }
				+    }
				+}
				 configMap: {
				     prometheus: {
				         apiVersion: "v1"
				@@ -2069,33 +2152,6 @@
				         }
				     }
				 }
				-service: {
				-    prometheus: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            annotations: {
				-                "prometheus.io/scrape": "true"
				-            }
				-            labels: {
				-                name: "prometheus"
				-            }
				-            name: "prometheus"
				-        }
				-        spec: {
				-            selector: {
				-                app: "prometheus"
				-            }
				-            type: "NodePort"
				-            ports: [{
				-                name:     "main"
				-                protocol: "TCP"
				-                port:     9090
				-                nodePort: 30900
				-            }]
				-        }
				-    }
				-}
				 deployment: {
				     prometheus: {
				         apiVersion: "apps/v1"
				@@ -2122,6 +2178,8 @@
				                     name: "prometheus"
				                     labels: {
				                         app: "prometheus"
				+                        domain:    "prod"
				+                        component: "mon"
				                     }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				@@ -2153,6 +2211,77 @@
				     }
				 }
				 // ---
				+service: {}
				+deployment: {}
				+// ---
				+service: {
				+    authproxy: {
				+        apiVersion: "v1"
				+        kind:       "Service"
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                app:       "authproxy"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+        spec: {
				+            ports: [{
				+                port:       4180
				+                targetPort: 4180
				+                protocol:   "TCP"
				+                name:       "client"
				+            }]
				+            selector: {
				+                app:       "authproxy"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+    }
				+}
				+deployment: {
				+    authproxy: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				+        metadata: {
				+            name: "authproxy"
				+        }
				+        spec: {
				+            replicas: 1
				+            template: {
				+                metadata: {
				+                    labels: {
				+                        app:       "authproxy"
				+                        domain:    "prod"
				+                        component: "proxy"
				+                    }
				+                }
				+                spec: {
				+                    containers: [{
				+                        name:  "authproxy"
				+                        image: "skippy/oauth2_proxy:2.0.1"
				+                        ports: [{
				+                            containerPort: 4180
				+                        }]
				+                        args: ["--config=/etc/authproxy/authproxy.cfg"]
				+                        volumeMounts: [{
				+                            name:      "config-volume"
				+                            mountPath: "/etc/authproxy"
				+                        }]
				+                    }]
				+                    volumes: [{
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "authproxy"
				+                        }
				+                    }]
				+                }
				+            }
				+        }
				+    }
				+}
				 configMap: {
				     authproxy: {
				         apiVersion: "v1"
				@@ -2217,71 +2346,36 @@
				         }
				     }
				 }
				-deployment: {
				-    authproxy: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "authproxy"
				-        }
				-        spec: {
				-            replicas: 1
				-            template: {
				-                metadata: {
				-                    labels: {
				-                        app:    "authproxy"
				-                        domain: "prod"
				-                    }
				-                }
				-                spec: {
				-                    containers: [{
				-                        name:  "authproxy"
				-                        image: "skippy/oauth2_proxy:2.0.1"
				-                        ports: [{
				-                            containerPort: 4180
				-                        }]
				-                        args: ["--config=/etc/authproxy/authproxy.cfg"]
				-                        volumeMounts: [{
				-                            name:      "config-volume"
				-                            mountPath: "/etc/authproxy"
				-                        }]
				-                    }]
				-                    volumes: [{
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "authproxy"
				-                        }
				-                    }]
				-                }
				-            }
				-        }
				-    }
				-}
				+// ---
				 service: {
				-    authproxy: {
				+    goget: {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				-            name: "authproxy"
				+            name: "goget"
				             labels: {
				-                app:    "authproxy"
				+                app:       "goget"
				                 domain: "prod"
				+                component: "proxy"
				             }
				         }
				         spec: {
				+            type:           "LoadBalancer"
				+            loadBalancerIP: "1.3.5.7"
				             ports: [{
				-                port:       4180
				-                targetPort: 4180
				+                port:       443
				+                targetPort: 7443
				                 protocol:   "TCP"
				-                name:       "client"
				+                name:       "https"
				             }]
				             selector: {
				-                app: "authproxy"
				+                app:       "goget"
				+                domain:    "prod"
				+                component: "proxy"
				             }
				         }
				     }
				 }
				-// ---
				 deployment: {
				     goget: {
				         apiVersion: "apps/v1"
				@@ -2295,6 +2389,7 @@
				                 metadata: {
				                     labels: {
				                         app:       "goget"
				+                        domain:    "prod"
				                         component: "proxy"
				                     }
				                 }
				@@ -2321,33 +2416,91 @@
				         }
				     }
				 }
				+// ---
				 service: {
				-    goget: {
				+    nginx: {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				-            name: "goget"
				+            name: "nginx"
				             labels: {
				-                app:       "goget"
				+                app:       "nginx"
				+                domain:    "prod"
				                 component: "proxy"
				             }
				         }
				         spec: {
				             type:           "LoadBalancer"
				-            loadBalancerIP: "1.3.5.7"
				+            loadBalancerIP: "1.3.4.5"
				             ports: [{
				+                port:       80
				+                targetPort: 80
				+                protocol:   "TCP"
				+                name:       "http"
				+            }, {
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "https"
				             }]
				             selector: {
				-                app: "goget"
				+                app:       "nginx"
				+                domain:    "prod"
				+                component: "proxy"
				+            }
				+        }
				+    }
				+}
				+deployment: {
				+    nginx: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				+        metadata: {
				+            name: "nginx"
				+        }
				+        spec: {
				+            replicas: 1
				+            template: {
				+                metadata: {
				+                    labels: {
				+                        app:       "nginx"
				+                        domain:    "prod"
				+                        component: "proxy"
				+                    }
				+                }
				+                spec: {
				+                    volumes: [{
				+                        name: "secret-volume"
				+                        secret: {
				+                            secretName: "proxy-secrets"
				+                        }
				+                    }, {
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "nginx"
				+                        }
				+                    }]
				+                    containers: [{
				+                        name:  "nginx"
				+                        image: "nginx:1.11.10-alpine"
				+                        ports: [{
				+                            containerPort: 80
				+                        }, {
				+                            containerPort: 443
				+                        }]
				+                        volumeMounts: [{
				+                            mountPath: "/etc/ssl"
				+                            name:      "secret-volume"
				+                        }, {
				+                            name:      "config-volume"
				+                            mountPath: "/etc/nginx/nginx.conf"
				+                            subPath:   "nginx.conf"
				+                        }]
				+                    }]
				+                }
				             }
				         }
				     }
				 }
				-// ---
				 configMap: {
				     nginx: {
				         apiVersion: "v1"
				@@ -2513,83 +2666,3 @@
				         }
				     }
				 }
				-deployment: {
				-    nginx: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "nginx"
				-        }
				-        spec: {
				-            replicas: 1
				-            template: {
				-                metadata: {
				-                    labels: {
				-                        app:       "nginx"
				-                        component: "proxy"
				-                    }
				-                }
				-                spec: {
				-                    volumes: [{
				-                        name: "secret-volume"
				-                        secret: {
				-                            secretName: "proxy-secrets"
				-                        }
				-                    }, {
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "nginx"
				-                        }
				-                    }]
				-                    containers: [{
				-                        name:  "nginx"
				-                        image: "nginx:1.11.10-alpine"
				-                        ports: [{
				-                            containerPort: 80
				-                        }, {
				-                            containerPort: 443
				-                        }]
				-                        volumeMounts: [{
				-                            mountPath: "/etc/ssl"
				-                            name:      "secret-volume"
				-                        }, {
				-                            name:      "config-volume"
				-                            mountPath: "/etc/nginx/nginx.conf"
				-                            subPath:   "nginx.conf"
				-                        }]
				-                    }]
				-                }
				-            }
				-        }
				-    }
				-}
				-service: {
				-    nginx: {
				-        apiVersion: "v1"
				-        kind:       "Service"
				-        metadata: {
				-            name: "nginx"
				-            labels: {
				-                app:       "nginx"
				-                component: "proxy"
				-            }
				-        }
				-        spec: {
				-            type:           "LoadBalancer"
				-            loadBalancerIP: "1.3.4.5"
				-            ports: [{
				-                port:       80
				-                targetPort: 80
				-                protocol:   "TCP"
				-                name:       "http"
				-            }, {
				-                port:     443
				-                protocol: "TCP"
				-                name:     "https"
				-            }]
				-            selector: {
				-                app: "nginx"
				-            }
				-        }
				-    }
				-}

				"""#
		}]
	}
	cp_snapshot1_snapshot2: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cp_snapshot1_snapshot2"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cp snapshot2 snapshot"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cue_trim_remove_boilerplate: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_trim_remove_boilerplate"
		Order:           23
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				 1889  3631 35031 total

				"""
			ComparisonOutput: """
				 1889  3631 35031 total

				"""
		}, {
			Negated:          false
			CmdStr:           "cue trim ./..."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				 1322  2412 23557 total

				"""
			ComparisonOutput: """
				 1322  2412 23557 total

				"""
		}]
	}
	cue_eval_check: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_eval_check"
		Order:           24
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue eval -c ./... >snapshot2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  true
			CmdStr:   "diff snapshot snapshot2"
			ExitCode: 1
			Output: """
				14d13
				<                 component: "frontend"
				16a16
				>                 component: "frontend"
				22d21
				<                 targetPort: 7080
				23a23
				>                 targetPort: 7080
				27d26
				<                 component: "frontend"
				29a29
				>                 component: "frontend"
				45,49d44
				<                     labels: {
				<                         component: "frontend"
				<                         app:       "bartender"
				<                         domain:    "prod"
				<                     }
				53a49,53
				>                     labels: {
				>                         app:       "bartender"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				57d56
				<                         name:  "bartender"
				61a61
				>                         name: "bartender"
				78d77
				<                 component: "frontend"
				79a79
				>                 component: "frontend"
				85d84
				<                 targetPort: 7080
				86a86
				>                 targetPort: 7080
				91d90
				<                 component: "frontend"
				92a92
				>                 component: "frontend"
				108,112d107
				<                     labels: {
				<                         app:       "breaddispatcher"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				116a112,116
				>                     labels: {
				>                         app:       "breaddispatcher"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				120d119
				<                         name:  "breaddispatcher"
				124a124
				>                         name: "breaddispatcher"
				141d140
				<                 component: "frontend"
				142a142
				>                 component: "frontend"
				148d147
				<                 targetPort: 7080
				149a149
				>                 targetPort: 7080
				154d153
				<                 component: "frontend"
				155a155
				>                 component: "frontend"
				170a171,173
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				173d175
				<                         component: "frontend"
				175,177c177
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "frontend"
				182d181
				<                         name:  "host"
				186a186
				>                         name: "host"
				203d202
				<                 component: "frontend"
				204a204
				>                 component: "frontend"
				210d209
				<                 targetPort: 7080
				211a211
				>                 targetPort: 7080
				233,237d232
				<                     labels: {
				<                         app:       "maitred"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				241a237,241
				>                     labels: {
				>                         app:       "maitred"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				245d244
				<                         name:  "maitred"
				249a249
				>                         name: "maitred"
				265d264
				<                 component: "frontend"
				267a267
				>                 component: "frontend"
				295a296,298
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				297d299
				<                         component: "frontend"
				300,302c302
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "frontend"
				307d306
				<                         name:  "valeter"
				311a311
				>                         name: "valeter"
				327d326
				<                 component: "frontend"
				329a329
				>                 component: "frontend"
				335d334
				<                 targetPort: 7080
				336a336
				>                 targetPort: 7080
				341d340
				<                 component: "frontend"
				342a342
				>                 component: "frontend"
				358,362d357
				<                     labels: {
				<                         component: "frontend"
				<                         app:       "waiter"
				<                         domain:    "prod"
				<                     }
				366a362,366
				>                     labels: {
				>                         app:       "waiter"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				370d369
				<                         name:  "waiter"
				371a371
				>                         name:  "waiter"
				390d389
				<                 component: "frontend"
				391a391
				>                 component: "frontend"
				403d402
				<                 component: "frontend"
				404a404
				>                 component: "frontend"
				420,424d419
				<                     labels: {
				<                         app:       "waterdispatcher"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				428a424,428
				>                     labels: {
				>                         app:       "waterdispatcher"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				432d431
				<                         name:  "waterdispatcher"
				436a436
				>                         name: "waterdispatcher"
				456d455
				<                 component: "infra"
				457a457
				>                 component: "infra"
				463d462
				<                 targetPort: 7080
				464a464
				>                 targetPort: 7080
				488d487
				<                         component: "infra"
				489a489
				>                         component: "infra"
				494d493
				<                         name:  "download"
				495a495
				>                         name:  "download"
				520,524d519
				<             selector: {
				<                 app:       "etcd"
				<                 domain:    "prod"
				<                 component: "infra"
				<             }
				527d521
				<                 targetPort: 2379
				528a523
				>                 targetPort: 2379
				535a531,535
				>             selector: {
				>                 app:       "etcd"
				>                 domain:    "prod"
				>                 component: "infra"
				>             }
				652d651
				<                 component: "infra"
				653a653
				>                 component: "infra"
				665d664
				<                 component: "infra"
				666a666
				>                 component: "infra"
				682,686d681
				<                     labels: {
				<                         app:       "events"
				<                         component: "infra"
				<                         domain:    "prod"
				<                     }
				690a686,690
				>                     labels: {
				>                         app:       "events"
				>                         domain:    "prod"
				>                         component: "infra"
				>                     }
				714d713
				<                         name:  "events"
				721a721
				>                         name: "events"
				772a773,776
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				778,781d781
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				791d790
				<                         name:  "tasks"
				797a797
				>                         name: "tasks"
				817d816
				<                 component: "infra"
				818a818
				>                 component: "infra"
				824d823
				<                 targetPort: 8080
				825a825
				>                 targetPort: 8080
				849d848
				<                         component: "infra"
				850a850
				>                         component: "infra"
				861d860
				<                         name:  "updater"
				869a869
				>                         name: "updater"
				886d885
				<                 component: "infra"
				887a887
				>                 component: "infra"
				901d900
				<                 component: "infra"
				902a902
				>                 component: "infra"
				920d919
				<                         component: "infra"
				921a921
				>                         component: "infra"
				932d931
				<                         name:  "watcher"
				938a938
				>                         name: "watcher"
				961d960
				<                 component: "kitchen"
				962a962
				>                 component: "kitchen"
				968d967
				<                 targetPort: 8080
				969a969
				>                 targetPort: 8080
				990a991,993
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				993d995
				<                         component: "kitchen"
				995,997c997
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1019d1018
				<                         name:  "caller"
				1036a1036
				>                         name: "caller"
				1060d1059
				<                 component: "kitchen"
				1061a1061
				>                 component: "kitchen"
				1067d1066
				<                 targetPort: 8080
				1068a1068
				>                 targetPort: 8080
				1073d1072
				<                 component: "kitchen"
				1074a1074
				>                 component: "kitchen"
				1089a1090,1092
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1092d1094
				<                         component: "kitchen"
				1094,1096c1096
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1118d1117
				<                         name:  "dishwasher"
				1135a1135
				>                         name: "dishwasher"
				1159d1158
				<                 component: "kitchen"
				1160a1160
				>                 component: "kitchen"
				1166d1165
				<                 targetPort: 8080
				1167a1167
				>                 targetPort: 8080
				1172d1171
				<                 component: "kitchen"
				1173a1173
				>                 component: "kitchen"
				1188a1189,1191
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1191d1193
				<                         component: "kitchen"
				1193,1195c1195
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1212d1211
				<                         name:  "expiditer"
				1225a1225
				>                         name: "expiditer"
				1249d1248
				<                 component: "kitchen"
				1250a1250
				>                 component: "kitchen"
				1256d1255
				<                 targetPort: 8080
				1257a1257
				>                 targetPort: 8080
				1262d1261
				<                 component: "kitchen"
				1263a1263
				>                 component: "kitchen"
				1278a1279,1281
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1281d1283
				<                         component: "kitchen"
				1283,1285c1285
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1302d1301
				<                         name:  "headchef"
				1315a1315
				>                         name: "headchef"
				1339d1338
				<                 component: "kitchen"
				1340a1340
				>                 component: "kitchen"
				1346d1345
				<                 targetPort: 8080
				1347a1347
				>                 targetPort: 8080
				1352d1351
				<                 component: "kitchen"
				1353a1353
				>                 component: "kitchen"
				1368a1369,1371
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1371d1373
				<                         component: "kitchen"
				1373,1375c1375
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1392d1391
				<                         name:  "linecook"
				1405a1405
				>                         name: "linecook"
				1429d1428
				<                 component: "kitchen"
				1430a1430
				>                 component: "kitchen"
				1436d1435
				<                 targetPort: 8080
				1437a1437
				>                 targetPort: 8080
				1442d1441
				<                 component: "kitchen"
				1443a1443
				>                 component: "kitchen"
				1458a1459,1461
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1461d1463
				<                         component: "kitchen"
				1463,1465c1465
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1482d1481
				<                         name:  "pastrychef"
				1495a1495
				>                         name: "pastrychef"
				1519d1518
				<                 component: "kitchen"
				1520a1520
				>                 component: "kitchen"
				1526d1525
				<                 targetPort: 8080
				1527a1527
				>                 targetPort: 8080
				1532d1531
				<                 component: "kitchen"
				1533a1533
				>                 component: "kitchen"
				1551d1550
				<                         component: "kitchen"
				1552a1552
				>                         component: "kitchen"
				1557d1556
				<                         name:  "souschef"
				1561a1561
				>                         name: "souschef"
				1588a1589
				>             name: "alertmanager"
				1595d1595
				<             name: "alertmanager"
				1598,1603d1597
				<             selector: {
				<                 app:       "alertmanager"
				<                 name:      "alertmanager"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1606d1599
				<                 protocol:   "TCP"
				1607a1601
				>                 protocol:   "TCP"
				1609a1604,1609
				>             selector: {
				>                 name:      "alertmanager"
				>                 app:       "alertmanager"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				1648d1647
				<             replicas: 1
				1653a1653
				>             replicas: 1
				1665d1664
				<                         name:  "alertmanager"
				1671a1671
				>                         name: "alertmanager"
				1708,1712d1707
				<             selector: {
				<                 app:       "grafana"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1715d1709
				<                 protocol:   "TCP"
				1716a1711
				>                 protocol:   "TCP"
				1718a1714,1718
				>             selector: {
				>                 app:       "grafana"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				1727d1726
				<             name: "grafana"
				1731a1731
				>             name: "grafana"
				1753d1752
				<                         name:  "grafana"
				1776a1776
				>                         name: "grafana"
				1792a1793,1796
				>             annotations: {
				>                 "prometheus.io/scrape": "true"
				>             }
				>             name: "node-exporter"
				1798,1801d1801
				<             annotations: {
				<                 "prometheus.io/scrape": "true"
				<             }
				<             name: "node-exporter"
				1891a1892
				>             name: "prometheus"
				1898d1898
				<             name: "prometheus"
				1901,1906d1900
				<             selector: {
				<                 app:       "prometheus"
				<                 name:      "prometheus"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1910d1903
				<                 protocol: "TCP"
				1911a1905
				>                 protocol: "TCP"
				1913a1908,1913
				>             selector: {
				>                 name:      "prometheus"
				>                 app:       "prometheus"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				2163d2162
				<             replicas: 1
				2175a2175
				>             replicas: 1
				2190d2189
				<                         name:  "prometheus"
				2196a2196
				>                         name: "prometheus"
				2232d2231
				<                 targetPort: 4180
				2233a2233
				>                 targetPort: 4180
				2263d2262
				<                         name:  "authproxy"
				2268a2268
				>                         name: "authproxy"
				2404d2403
				<                         name:  "goget"
				2408a2408
				>                         name: "goget"
				2483d2482
				<                         name:  "nginx"
				2489a2489
				>                         name: "nginx"

				"""
			ComparisonOutput: """
				14d13
				<                 component: "frontend"
				16a16
				>                 component: "frontend"
				22d21
				<                 targetPort: 7080
				23a23
				>                 targetPort: 7080
				27d26
				<                 component: "frontend"
				29a29
				>                 component: "frontend"
				45,49d44
				<                     labels: {
				<                         component: "frontend"
				<                         app:       "bartender"
				<                         domain:    "prod"
				<                     }
				53a49,53
				>                     labels: {
				>                         app:       "bartender"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				57d56
				<                         name:  "bartender"
				61a61
				>                         name: "bartender"
				78d77
				<                 component: "frontend"
				79a79
				>                 component: "frontend"
				85d84
				<                 targetPort: 7080
				86a86
				>                 targetPort: 7080
				91d90
				<                 component: "frontend"
				92a92
				>                 component: "frontend"
				108,112d107
				<                     labels: {
				<                         app:       "breaddispatcher"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				116a112,116
				>                     labels: {
				>                         app:       "breaddispatcher"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				120d119
				<                         name:  "breaddispatcher"
				124a124
				>                         name: "breaddispatcher"
				141d140
				<                 component: "frontend"
				142a142
				>                 component: "frontend"
				148d147
				<                 targetPort: 7080
				149a149
				>                 targetPort: 7080
				154d153
				<                 component: "frontend"
				155a155
				>                 component: "frontend"
				170a171,173
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				173d175
				<                         component: "frontend"
				175,177c177
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "frontend"
				182d181
				<                         name:  "host"
				186a186
				>                         name: "host"
				203d202
				<                 component: "frontend"
				204a204
				>                 component: "frontend"
				210d209
				<                 targetPort: 7080
				211a211
				>                 targetPort: 7080
				233,237d232
				<                     labels: {
				<                         app:       "maitred"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				241a237,241
				>                     labels: {
				>                         app:       "maitred"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				245d244
				<                         name:  "maitred"
				249a249
				>                         name: "maitred"
				265d264
				<                 component: "frontend"
				267a267
				>                 component: "frontend"
				295a296,298
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				297d299
				<                         component: "frontend"
				300,302c302
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "frontend"
				307d306
				<                         name:  "valeter"
				311a311
				>                         name: "valeter"
				327d326
				<                 component: "frontend"
				329a329
				>                 component: "frontend"
				335d334
				<                 targetPort: 7080
				336a336
				>                 targetPort: 7080
				341d340
				<                 component: "frontend"
				342a342
				>                 component: "frontend"
				358,362d357
				<                     labels: {
				<                         component: "frontend"
				<                         app:       "waiter"
				<                         domain:    "prod"
				<                     }
				366a362,366
				>                     labels: {
				>                         app:       "waiter"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				370d369
				<                         name:  "waiter"
				371a371
				>                         name:  "waiter"
				390d389
				<                 component: "frontend"
				391a391
				>                 component: "frontend"
				403d402
				<                 component: "frontend"
				404a404
				>                 component: "frontend"
				420,424d419
				<                     labels: {
				<                         app:       "waterdispatcher"
				<                         component: "frontend"
				<                         domain:    "prod"
				<                     }
				428a424,428
				>                     labels: {
				>                         app:       "waterdispatcher"
				>                         domain:    "prod"
				>                         component: "frontend"
				>                     }
				432d431
				<                         name:  "waterdispatcher"
				436a436
				>                         name: "waterdispatcher"
				456d455
				<                 component: "infra"
				457a457
				>                 component: "infra"
				463d462
				<                 targetPort: 7080
				464a464
				>                 targetPort: 7080
				488d487
				<                         component: "infra"
				489a489
				>                         component: "infra"
				494d493
				<                         name:  "download"
				495a495
				>                         name:  "download"
				520,524d519
				<             selector: {
				<                 app:       "etcd"
				<                 domain:    "prod"
				<                 component: "infra"
				<             }
				527d521
				<                 targetPort: 2379
				528a523
				>                 targetPort: 2379
				535a531,535
				>             selector: {
				>                 app:       "etcd"
				>                 domain:    "prod"
				>                 component: "infra"
				>             }
				652d651
				<                 component: "infra"
				653a653
				>                 component: "infra"
				665d664
				<                 component: "infra"
				666a666
				>                 component: "infra"
				682,686d681
				<                     labels: {
				<                         app:       "events"
				<                         component: "infra"
				<                         domain:    "prod"
				<                     }
				690a686,690
				>                     labels: {
				>                         app:       "events"
				>                         domain:    "prod"
				>                         component: "infra"
				>                     }
				714d713
				<                         name:  "events"
				721a721
				>                         name: "events"
				772a773,776
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				778,781d781
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				791d790
				<                         name:  "tasks"
				797a797
				>                         name: "tasks"
				817d816
				<                 component: "infra"
				818a818
				>                 component: "infra"
				824d823
				<                 targetPort: 8080
				825a825
				>                 targetPort: 8080
				849d848
				<                         component: "infra"
				850a850
				>                         component: "infra"
				861d860
				<                         name:  "updater"
				869a869
				>                         name: "updater"
				886d885
				<                 component: "infra"
				887a887
				>                 component: "infra"
				901d900
				<                 component: "infra"
				902a902
				>                 component: "infra"
				920d919
				<                         component: "infra"
				921a921
				>                         component: "infra"
				932d931
				<                         name:  "watcher"
				938a938
				>                         name: "watcher"
				961d960
				<                 component: "kitchen"
				962a962
				>                 component: "kitchen"
				968d967
				<                 targetPort: 8080
				969a969
				>                 targetPort: 8080
				990a991,993
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				993d995
				<                         component: "kitchen"
				995,997c997
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1019d1018
				<                         name:  "caller"
				1036a1036
				>                         name: "caller"
				1060d1059
				<                 component: "kitchen"
				1061a1061
				>                 component: "kitchen"
				1067d1066
				<                 targetPort: 8080
				1068a1068
				>                 targetPort: 8080
				1073d1072
				<                 component: "kitchen"
				1074a1074
				>                 component: "kitchen"
				1089a1090,1092
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1092d1094
				<                         component: "kitchen"
				1094,1096c1096
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1118d1117
				<                         name:  "dishwasher"
				1135a1135
				>                         name: "dishwasher"
				1159d1158
				<                 component: "kitchen"
				1160a1160
				>                 component: "kitchen"
				1166d1165
				<                 targetPort: 8080
				1167a1167
				>                 targetPort: 8080
				1172d1171
				<                 component: "kitchen"
				1173a1173
				>                 component: "kitchen"
				1188a1189,1191
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1191d1193
				<                         component: "kitchen"
				1193,1195c1195
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1212d1211
				<                         name:  "expiditer"
				1225a1225
				>                         name: "expiditer"
				1249d1248
				<                 component: "kitchen"
				1250a1250
				>                 component: "kitchen"
				1256d1255
				<                 targetPort: 8080
				1257a1257
				>                 targetPort: 8080
				1262d1261
				<                 component: "kitchen"
				1263a1263
				>                 component: "kitchen"
				1278a1279,1281
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1281d1283
				<                         component: "kitchen"
				1283,1285c1285
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1302d1301
				<                         name:  "headchef"
				1315a1315
				>                         name: "headchef"
				1339d1338
				<                 component: "kitchen"
				1340a1340
				>                 component: "kitchen"
				1346d1345
				<                 targetPort: 8080
				1347a1347
				>                 targetPort: 8080
				1352d1351
				<                 component: "kitchen"
				1353a1353
				>                 component: "kitchen"
				1368a1369,1371
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1371d1373
				<                         component: "kitchen"
				1373,1375c1375
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1392d1391
				<                         name:  "linecook"
				1405a1405
				>                         name: "linecook"
				1429d1428
				<                 component: "kitchen"
				1430a1430
				>                 component: "kitchen"
				1436d1435
				<                 targetPort: 8080
				1437a1437
				>                 targetPort: 8080
				1442d1441
				<                 component: "kitchen"
				1443a1443
				>                 component: "kitchen"
				1458a1459,1461
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1461d1463
				<                         component: "kitchen"
				1463,1465c1465
				<                     }
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				---
				>                         component: "kitchen"
				1482d1481
				<                         name:  "pastrychef"
				1495a1495
				>                         name: "pastrychef"
				1519d1518
				<                 component: "kitchen"
				1520a1520
				>                 component: "kitchen"
				1526d1525
				<                 targetPort: 8080
				1527a1527
				>                 targetPort: 8080
				1532d1531
				<                 component: "kitchen"
				1533a1533
				>                 component: "kitchen"
				1551d1550
				<                         component: "kitchen"
				1552a1552
				>                         component: "kitchen"
				1557d1556
				<                         name:  "souschef"
				1561a1561
				>                         name: "souschef"
				1588a1589
				>             name: "alertmanager"
				1595d1595
				<             name: "alertmanager"
				1598,1603d1597
				<             selector: {
				<                 app:       "alertmanager"
				<                 name:      "alertmanager"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1606d1599
				<                 protocol:   "TCP"
				1607a1601
				>                 protocol:   "TCP"
				1609a1604,1609
				>             selector: {
				>                 name:      "alertmanager"
				>                 app:       "alertmanager"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				1648d1647
				<             replicas: 1
				1653a1653
				>             replicas: 1
				1665d1664
				<                         name:  "alertmanager"
				1671a1671
				>                         name: "alertmanager"
				1708,1712d1707
				<             selector: {
				<                 app:       "grafana"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1715d1709
				<                 protocol:   "TCP"
				1716a1711
				>                 protocol:   "TCP"
				1718a1714,1718
				>             selector: {
				>                 app:       "grafana"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				1727d1726
				<             name: "grafana"
				1731a1731
				>             name: "grafana"
				1753d1752
				<                         name:  "grafana"
				1776a1776
				>                         name: "grafana"
				1792a1793,1796
				>             annotations: {
				>                 "prometheus.io/scrape": "true"
				>             }
				>             name: "node-exporter"
				1798,1801d1801
				<             annotations: {
				<                 "prometheus.io/scrape": "true"
				<             }
				<             name: "node-exporter"
				1891a1892
				>             name: "prometheus"
				1898d1898
				<             name: "prometheus"
				1901,1906d1900
				<             selector: {
				<                 app:       "prometheus"
				<                 name:      "prometheus"
				<                 domain:    "prod"
				<                 component: "mon"
				<             }
				1910d1903
				<                 protocol: "TCP"
				1911a1905
				>                 protocol: "TCP"
				1913a1908,1913
				>             selector: {
				>                 name:      "prometheus"
				>                 app:       "prometheus"
				>                 domain:    "prod"
				>                 component: "mon"
				>             }
				2163d2162
				<             replicas: 1
				2175a2175
				>             replicas: 1
				2190d2189
				<                         name:  "prometheus"
				2196a2196
				>                         name: "prometheus"
				2232d2231
				<                 targetPort: 4180
				2233a2233
				>                 targetPort: 4180
				2263d2262
				<                         name:  "authproxy"
				2268a2268
				>                         name: "authproxy"
				2404d2403
				<                         name:  "goget"
				2408a2408
				>                         name: "goget"
				2483d2482
				<                         name:  "nginx"
				2489a2489
				>                         name: "nginx"

				"""
		}]
	}
	daemon_stateful_template: {
		StepType: 2
		Name:     "daemon_stateful_template"
		Order:    25
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 3
			Pre: """
				package kube

				service: [ID=_]: {
				\tapiVersion: "v1"
				\tkind:       "Service"
				\tmetadata: {
				\t\tname: ID
				\t\tlabels: {
				\t\t\tapp:       ID         // by convention
				\t\t\tdomain:    "prod"     // always the same in the given files
				\t\t\tcomponent: #Component // varies per directory
				\t\t}
				\t}
				\tspec: {
				\t\t// Any port has the following properties.
				\t\tports: [...{
				\t\t\tport:     int
				\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
				\t\t\tname:     string | *"client"
				\t\t}]
				\t\tselector: metadata.labels // we want those to be the same
				\t}
				}

				deployment: [ID=_]: {
				\tapiVersion: "apps/v1"
				\tkind:       "Deployment"
				\tmetadata: name: ID
				\tspec: {
				\t\t// 1 is the default, but we allow any number
				\t\treplicas: *1 | int
				\t\ttemplate: {
				\t\t\tmetadata: labels: {
				\t\t\t\tapp:       ID
				\t\t\t\tdomain:    "prod"
				\t\t\t\tcomponent: #Component
				\t\t\t}
				\t\t\t// we always have one namesake container
				\t\t\tspec: containers: [{name: ID}]
				\t\t}
				\t}
				}

				#Component: string

				"""
		}
		Source: """
			package kube

			service: [ID=_]: {
			\tapiVersion: "v1"
			\tkind:       "Service"
			\tmetadata: {
			\t\tname: ID
			\t\tlabels: {
			\t\t\tapp:       ID         // by convention
			\t\t\tdomain:    "prod"     // always the same in the given files
			\t\t\tcomponent: #Component // varies per directory
			\t\t}
			\t}
			\tspec: {
			\t\t// Any port has the following properties.
			\t\tports: [...{
			\t\t\tport:     int
			\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
			\t\t\tname:     string | *"client"
			\t\t}]
			\t\tselector: metadata.labels // we want those to be the same
			\t}
			}

			deployment: [ID=_]: {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\tmetadata: name: ID
			\tspec: {
			\t\t// 1 is the default, but we allow any number
			\t\treplicas: *1 | int
			\t\ttemplate: {
			\t\t\tmetadata: labels: {
			\t\t\t\tapp:       ID
			\t\t\t\tdomain:    "prod"
			\t\t\t\tcomponent: #Component
			\t\t\t}
			\t\t\t// we always have one namesake container
			\t\t\tspec: containers: [{name: ID}]
			\t\t}
			\t}
			}

			#Component: string

			daemonSet: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "DaemonSet"
			\t_name:      ID
			}

			statefulSet: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "StatefulSet"
			\t_name:      ID
			}

			deployment: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\t_name:      ID
			\tspec: replicas: *1 | int
			}

			configMap: [ID=_]: {
			\tmetadata: name: ID
			\tmetadata: labels: component: #Component
			}

			_spec: {
			\t_name: string

			\tmetadata: name: _name
			\tmetadata: labels: component: #Component
			\tspec: selector: {}
			\tspec: template: {
			\t\tmetadata: labels: {
			\t\t\tapp:       _name
			\t\t\tcomponent: #Component
			\t\t\tdomain:    "prod"
			\t\t}
			\t\tspec: containers: [{name: _name}]
			\t}
			}

			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/kube.cue"
	}
	service_template: {
		StepType: 2
		Name:     "service_template"
		Order:    26
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 3
			Pre: """
				package kube

				service: [ID=_]: {
				\tapiVersion: "v1"
				\tkind:       "Service"
				\tmetadata: {
				\t\tname: ID
				\t\tlabels: {
				\t\t\tapp:       ID         // by convention
				\t\t\tdomain:    "prod"     // always the same in the given files
				\t\t\tcomponent: #Component // varies per directory
				\t\t}
				\t}
				\tspec: {
				\t\t// Any port has the following properties.
				\t\tports: [...{
				\t\t\tport:     int
				\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
				\t\t\tname:     string | *"client"
				\t\t}]
				\t\tselector: metadata.labels // we want those to be the same
				\t}
				}

				deployment: [ID=_]: {
				\tapiVersion: "apps/v1"
				\tkind:       "Deployment"
				\tmetadata: name: ID
				\tspec: {
				\t\t// 1 is the default, but we allow any number
				\t\treplicas: *1 | int
				\t\ttemplate: {
				\t\t\tmetadata: labels: {
				\t\t\t\tapp:       ID
				\t\t\t\tdomain:    "prod"
				\t\t\t\tcomponent: #Component
				\t\t\t}
				\t\t\t// we always have one namesake container
				\t\t\tspec: containers: [{name: ID}]
				\t\t}
				\t}
				}

				#Component: string

				daemonSet: [ID=_]: _spec & {
				\tapiVersion: "apps/v1"
				\tkind:       "DaemonSet"
				\t_name:      ID
				}

				statefulSet: [ID=_]: _spec & {
				\tapiVersion: "apps/v1"
				\tkind:       "StatefulSet"
				\t_name:      ID
				}

				deployment: [ID=_]: _spec & {
				\tapiVersion: "apps/v1"
				\tkind:       "Deployment"
				\t_name:      ID
				\tspec: replicas: *1 | int
				}

				configMap: [ID=_]: {
				\tmetadata: name: ID
				\tmetadata: labels: component: #Component
				}

				_spec: {
				\t_name: string

				\tmetadata: name: _name
				\tmetadata: labels: component: #Component
				\tspec: selector: {}
				\tspec: template: {
				\t\tmetadata: labels: {
				\t\t\tapp:       _name
				\t\t\tcomponent: #Component
				\t\t\tdomain:    "prod"
				\t\t}
				\t\tspec: containers: [{name: _name}]
				\t}
				}

				"""
		}
		Source: """
			package kube

			service: [ID=_]: {
			\tapiVersion: "v1"
			\tkind:       "Service"
			\tmetadata: {
			\t\tname: ID
			\t\tlabels: {
			\t\t\tapp:       ID         // by convention
			\t\t\tdomain:    "prod"     // always the same in the given files
			\t\t\tcomponent: #Component // varies per directory
			\t\t}
			\t}
			\tspec: {
			\t\t// Any port has the following properties.
			\t\tports: [...{
			\t\t\tport:     int
			\t\t\tprotocol: *"TCP" | "UDP" // from the Kubernetes definition
			\t\t\tname:     string | *"client"
			\t\t}]
			\t\tselector: metadata.labels // we want those to be the same
			\t}
			}

			deployment: [ID=_]: {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\tmetadata: name: ID
			\tspec: {
			\t\t// 1 is the default, but we allow any number
			\t\treplicas: *1 | int
			\t\ttemplate: {
			\t\t\tmetadata: labels: {
			\t\t\t\tapp:       ID
			\t\t\t\tdomain:    "prod"
			\t\t\t\tcomponent: #Component
			\t\t\t}
			\t\t\t// we always have one namesake container
			\t\t\tspec: containers: [{name: ID}]
			\t\t}
			\t}
			}

			#Component: string

			daemonSet: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "DaemonSet"
			\t_name:      ID
			}

			statefulSet: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "StatefulSet"
			\t_name:      ID
			}

			deployment: [ID=_]: _spec & {
			\tapiVersion: "apps/v1"
			\tkind:       "Deployment"
			\t_name:      ID
			\tspec: replicas: *1 | int
			}

			configMap: [ID=_]: {
			\tmetadata: name: ID
			\tmetadata: labels: component: #Component
			}

			_spec: {
			\t_name: string

			\tmetadata: name: _name
			\tmetadata: labels: component: #Component
			\tspec: selector: {}
			\tspec: template: {
			\t\tmetadata: labels: {
			\t\t\tapp:       _name
			\t\t\tcomponent: #Component
			\t\t\tdomain:    "prod"
			\t\t}
			\t\tspec: containers: [{name: _name}]
			\t}
			}

			// Define the _export option and set the default to true
			// for all ports defined in all containers.
			_spec: spec: template: spec: containers: [...{
			\tports: [...{
			\t\t_export: *true | false // include the port in the service
			\t}]
			}]

			for x in [deployment, daemonSet, statefulSet] for k, v in x {
			\tservice: "\\(k)": {
			\t\tspec: selector: v.spec.template.metadata.labels

			\t\tspec: ports: [
			\t\t\tfor c in v.spec.template.spec.containers
			\t\t\tfor p in c.ports
			\t\t\tif p._export {
			\t\t\t\tlet Port = p.containerPort // Port is an alias
			\t\t\t\tport:       *Port | int
			\t\t\t\ttargetPort: *Port | int
			\t\t\t},
			\t\t]
			\t}
			}

			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/kube.cue"
	}
	fix_infra_kubes: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "fix_infra_kubes"
		Order:           27
		Terminal:        "term1"
		Stmts: [{
			Negated: false
			CmdStr: """
				cat <<EOF >>infra/events/kube.cue

				deployment: events: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated: false
			CmdStr: """
				cat <<EOF >>infra/tasks/kube.cue

				deployment: tasks: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated: false
			CmdStr: """
				cat <<EOF >>infra/watcher/kube.cue

				deployment: watcher: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	trim_post_infra_fixup: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "trim_post_infra_fixup"
		Order:           28
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue trim ./..."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				 1252  2366 23155 total

				"""
			ComparisonOutput: """
				 1252  2366 23155 total

				"""
		}]
	}
	trim_simplify: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "trim_simplify"
		Order:           29
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "head frontend/breaddispatcher/kube.cue"
			ExitCode: 0
			Output: """
				package kube

				deployment: breaddispatcher: {
				\tspec: {
				\t\ttemplate: {
				\t\t\tmetadata: {
				\t\t\t\tannotations: {
				\t\t\t\t\t"prometheus.io.scrape": "true"
				\t\t\t\t\t"prometheus.io.port":   "7080"
				\t\t\t\t}

				"""
			ComparisonOutput: """
				package kube

				deployment: breaddispatcher: {
				\tspec: {
				\t\ttemplate: {
				\t\t\tmetadata: {
				\t\t\t\tannotations: {
				\t\t\t\t\t"prometheus.io.scrape": "true"
				\t\t\t\t\t"prometheus.io.port":   "7080"
				\t\t\t\t}

				"""
		}, {
			Negated:          false
			CmdStr:           "cue trim ./... -s"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "head -7 frontend/breaddispatcher/kube.cue"
			ExitCode: 0
			Output: """
				package kube

				deployment: breaddispatcher: spec: template: {
				\tmetadata: annotations: {
				\t\t"prometheus.io.scrape": "true"
				\t\t"prometheus.io.port":   "7080"
				\t}

				"""
			ComparisonOutput: """
				package kube

				deployment: breaddispatcher: spec: template: {
				\tmetadata: annotations: {
				\t\t"prometheus.io.scrape": "true"
				\t\t"prometheus.io.port":   "7080"
				\t}

				"""
		}, {
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				 1106  2220 21391 total

				"""
			ComparisonOutput: """
				 1106  2220 21391 total

				"""
		}]
	}
	simplify_frontend: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "simplify_frontend"
		Order:           30
		Terminal:        "term1"
		Stmts: [{
			Negated: false
			CmdStr: """
				cat <<EOF >>frontend/kube.cue

				deployment: [string]: spec: template: {
				\tmetadata: annotations: {
				\t\t"prometheus.io.scrape": "true"
				\t\t"prometheus.io.port":   "\\(spec.containers[0].ports[0].containerPort)"
				\t}
				\tspec: containers: [{
				\t\tports: [{containerPort: *7080 | int}] // 7080 is the default
				\t}]
				}
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cue fmt ./frontend"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	check_diffs_post_frontend_simplify: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "check_diffs_post_frontend_simplify"
		Order:           31
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue eval -c ./... >snapshot2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  true
			CmdStr:   "diff -wu snapshot snapshot2"
			ExitCode: 1
			Output: #"""
				--- snapshot\#t2021-05-28 16:42:14.198578533 +0000
				+++ snapshot2\#t2021-05-28 16:42:36.449947811 +0000
				@@ -1,8 +1,14 @@
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     bartender: {
				@@ -11,22 +17,22 @@
				         metadata: {
				             name: "bartender"
				             labels: {
				-                component: "frontend"
				                 app:       "bartender"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				-                component: "frontend"
				                 app:       "bartender"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -35,37 +41,44 @@
				     bartender: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "bartender"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        component: "frontend"
				-                        app:       "bartender"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "bartender"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "bartender"
				                         image: "gcr.io/myproj/bartender:v0.1.34"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "bartender"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "bartender"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     breaddispatcher: {
				@@ -75,21 +88,21 @@
				             name: "breaddispatcher"
				             labels: {
				                 app:       "breaddispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "breaddispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -98,37 +111,44 @@
				     breaddispatcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "breaddispatcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "breaddispatcher"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "breaddispatcher"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "breaddispatcher"
				                         image: "gcr.io/myproj/breaddispatcher:v0.3.24"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "breaddispatcher"
				                         args: ["-etcd=etcd:2379", "-event-server=events:7788"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "breaddispatcher"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     host: {
				@@ -138,21 +158,21 @@
				             name: "host"
				             labels: {
				                 app:       "host"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "host"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -161,36 +181,44 @@
				     host: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "host"
				-        }
				         spec: {
				             replicas: 2
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "7080"
				+                    }
				                     labels: {
				                         app:       "host"
				-                        component: "frontend"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "frontend"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "host"
				                         image: "gcr.io/myproj/host:v0.1.10"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "host"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "host"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     maitred: {
				@@ -200,15 +228,15 @@
				             name: "maitred"
				             labels: {
				                 app:       "maitred"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				@@ -223,37 +251,44 @@
				     maitred: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "maitred"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "maitred"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "maitred"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "maitred"
				                         image: "gcr.io/myproj/maitred:v0.0.4"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "maitred"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "maitred"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     valeter: {
				@@ -262,17 +297,17 @@
				         metadata: {
				             name: "valeter"
				             labels: {
				-                component: "frontend"
				                 app:       "valeter"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 8080
				             }]
				             selector: {
				                 app:       "valeter"
				@@ -286,36 +321,44 @@
				     valeter: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "valeter"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "8080"
				+                    }
				                     labels: {
				-                        component: "frontend"
				                         app:       "valeter"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "frontend"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "valeter"
				                         image: "gcr.io/myproj/valeter:v0.0.4"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "valeter"
				                         args: ["-http=:8080", "-etcd=etcd:2379"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "valeter"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     waiter: {
				@@ -324,22 +367,22 @@
				         metadata: {
				             name: "waiter"
				             labels: {
				-                component: "frontend"
				                 app:       "waiter"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "waiter"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -348,27 +391,25 @@
				     waiter: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "waiter"
				-        }
				         spec: {
				             replicas: 5
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        component: "frontend"
				-                        app:       "waiter"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "waiter"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "waiter"
				                         image: "gcr.io/myproj/waiter:v0.3.0"
				+                        name:  "waiter"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				@@ -376,8 +417,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "waiter"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     waterdispatcher: {
				@@ -387,21 +437,21 @@
				             name: "waterdispatcher"
				             labels: {
				                 app:       "waterdispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7080
				             }]
				             selector: {
				                 app:       "waterdispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -410,40 +460,50 @@
				     waterdispatcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "waterdispatcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "waterdispatcher"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "waterdispatcher"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "waterdispatcher"
				                         image: "gcr.io/myproj/waterdispatcher:v0.0.48"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "waterdispatcher"
				                         args: ["-http=:8080", "-etcd=etcd:2379"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "waterdispatcher"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     download: {
				@@ -453,15 +513,15 @@
				             name: "download"
				             labels: {
				                 app:       "download"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				@@ -476,23 +536,21 @@
				     download: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "download"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "download"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "download"
				                         image: "gcr.io/myproj/download:v0.0.2"
				+                        name:  "download"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				@@ -500,8 +558,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "download"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     etcd: {
				@@ -517,46 +584,45 @@
				         }
				         spec: {
				             clusterIP: "None"
				-            selector: {
				-                app:       "etcd"
				-                domain:    "prod"
				-                component: "infra"
				-            }
				             ports: [{
				                 port:       2379
				-                targetPort: 2379
				                 protocol:   "TCP"
				+                targetPort: 2379
				                 name:       "client"
				             }, {
				                 port:       2380
				-                targetPort: 2380
				                 protocol:   "TCP"
				                 name:       "peer"
				+                targetPort: 2380
				             }]
				+            selector: {
				+                app:       "etcd"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				         }
				     }
				 }
				 deployment: {}
				+daemonSet: {}
				 statefulSet: {
				     etcd: {
				         apiVersion: "apps/v1"
				         kind:       "StatefulSet"
				-        metadata: {
				-            name: "etcd"
				-        }
				         spec: {
				             serviceName: "etcd"
				             replicas:    3
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "etcd"
				-                        component: "infra"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "2379"
				                     }
				+                    labels: {
				+                        app:       "etcd"
				+                        component: "infra"
				+                        domain:    "prod"
				+                    }
				                 }
				                 spec: {
				                     affinity: {
				@@ -575,7 +641,6 @@
				                     }
				                     terminationGracePeriodSeconds: 10
				                     containers: [{
				-                        name:  "etcd"
				                         image: "quay.io/coreos/etcd:v3.3.10"
				                         ports: [{
				                             name:          "client"
				@@ -617,10 +682,12 @@
				                             }
				                         }]
				                         command: ["/usr/local/bin/etcd"]
				+                        name: "etcd"
				                         args: ["-name", "$(NAME)", "-data-dir", "/data/etcd3", "-initial-advertise-peer-urls", "http://$(IP):2380", "-listen-peer-urls", "http://$(IP):2380", "-listen-client-urls", "http://$(IP):2379,http://127.0.0.1:2379", "-advertise-client-urls", "http://$(IP):2379", "-discovery", "https://discovery.etcd.io/xxxxxx"]
				                     }]
				                 }
				             }
				+            selector: {}
				             volumeClaimTemplates: [{
				                 metadata: {
				                     name: "etcd3"
				@@ -638,8 +705,15 @@
				                 }
				             }]
				         }
				+        metadata: {
				+            name: "etcd"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+configMap: {}
				 // ---
				 service: {
				     events: {
				@@ -649,21 +723,21 @@
				             name: "events"
				             labels: {
				                 app:       "events"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7788
				-                targetPort: 7788
				                 protocol:   "TCP"
				                 name:       "grpc"
				+                targetPort: 7788
				             }]
				             selector: {
				                 app:       "events"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -672,22 +746,20 @@
				     events: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "events"
				-        }
				         spec: {
				             replicas: 2
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "events"
				-                        component: "infra"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "events"
				+                        domain:    "prod"
				+                        component: "infra"
				+                    }
				                 }
				                 spec: {
				                     affinity: {
				@@ -711,7 +783,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "events"
				                         image: "gcr.io/myproj/events:v0.1.31"
				                         ports: [{
				                             containerPort: 7080
				@@ -719,6 +790,7 @@
				                             containerPort: 7788
				                         }]
				                         args: ["-cert=/etc/ssl/server.pem", "-key=/etc/ssl/server.key", "-grpc=:7788"]
				+                        name: "events"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -727,8 +799,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "events"
				+            labels: {
				+                component: "infra"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     tasks: {
				@@ -747,9 +828,9 @@
				             loadBalancerIP: "1.2.3.4"
				             ports: [{
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7443
				             }]
				             selector: {
				                 app:       "tasks"
				@@ -763,22 +844,20 @@
				     tasks: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "tasks"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "7080"
				+                    }
				                     labels: {
				                         app:       "tasks"
				                         domain:    "prod"
				                         component: "infra"
				                     }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				-                        "prometheus.io.port":   "7080"
				-                    }
				                 }
				                 spec: {
				                     volumes: [{
				@@ -788,13 +867,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "tasks"
				                         image: "gcr.io/myproj/tasks:v0.2.6"
				                         ports: [{
				                             containerPort: 7080
				                         }, {
				                             containerPort: 7443
				                         }]
				+                        name: "tasks"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -803,8 +882,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "tasks"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     updater: {
				@@ -814,15 +902,15 @@
				             name: "updater"
				             labels: {
				                 app:       "updater"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				@@ -837,17 +925,15 @@
				     updater: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "updater"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "updater"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				@@ -858,7 +944,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "updater"
				                         image: "gcr.io/myproj/updater:v0.1.0"
				                         volumeMounts: [{
				                             mountPath: "/etc/certs"
				@@ -867,13 +952,23 @@
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "updater"
				                         args: ["-key=/etc/certs/updater.pem"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "updater"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     watcher: {
				@@ -883,8 +978,8 @@
				             name: "watcher"
				             labels: {
				                 app:       "watcher"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				@@ -892,14 +987,14 @@
				             loadBalancerIP: "1.2.3.4."
				             ports: [{
				                 port:       7788
				-                targetPort: 7788
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7788
				             }]
				             selector: {
				                 app:       "watcher"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -908,17 +1003,15 @@
				     watcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "watcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "watcher"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				@@ -929,13 +1022,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "watcher"
				                         image: "gcr.io/myproj/watcher:v0.1.0"
				                         ports: [{
				                             containerPort: 7080
				                         }, {
				                             containerPort: 7788
				                         }]
				+                        name: "watcher"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -944,11 +1037,23 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "watcher"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     caller: {
				@@ -958,15 +1063,15 @@
				             name: "caller"
				             labels: {
				                 app:       "caller"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				@@ -981,20 +1086,18 @@
				     caller: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "caller"
				-        }
				         spec: {
				             replicas: 3
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "caller"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1016,7 +1119,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "caller"
				                         image: "gcr.io/myproj/caller:v0.20.14"
				                         volumeMounts: [{
				                             name:      "ssd-caller"
				@@ -1034,6 +1136,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-key=/etc/certs/client.key", "-cert=/etc/certs/client.pem", "-ca=/etc/certs/servfx.ca", "-ssh-tunnel-key=/sslcerts/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "caller"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1046,8 +1149,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "caller"
				+            labels: {
				+                component: "kitchen"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     dishwasher: {
				@@ -1057,21 +1169,21 @@
				             name: "dishwasher"
				             labels: {
				                 app:       "dishwasher"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "dishwasher"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1080,20 +1192,18 @@
				     dishwasher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "dishwasher"
				-        }
				         spec: {
				             replicas: 5
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "dishwasher"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1115,7 +1225,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "dishwasher"
				                         image: "gcr.io/myproj/dishwasher:v0.2.13"
				                         volumeMounts: [{
				                             name:      "dishwasher-disk"
				@@ -1133,6 +1242,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "dishwasher"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1145,8 +1255,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "dishwasher"
				+            labels: {
				+                component: "kitchen"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     expiditer: {
				@@ -1156,21 +1275,21 @@
				             name: "expiditer"
				             labels: {
				                 app:       "expiditer"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "expiditer"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1179,20 +1298,18 @@
				     expiditer: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "expiditer"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "expiditer"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1209,7 +1326,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "expiditer"
				                         image: "gcr.io/myproj/expiditer:v0.5.34"
				                         volumeMounts: [{
				                             name:      "expiditer-disk"
				@@ -1223,6 +1339,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "expiditer"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1235,8 +1352,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "expiditer"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     headchef: {
				@@ -1246,21 +1372,21 @@
				             name: "headchef"
				             labels: {
				                 app:       "headchef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "headchef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1269,20 +1395,18 @@
				     headchef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "headchef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "headchef"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1299,7 +1423,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "headchef"
				                         image: "gcr.io/myproj/headchef:v0.2.16"
				                         volumeMounts: [{
				                             name:      "headchef-disk"
				@@ -1313,6 +1436,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "headchef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1325,8 +1449,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "headchef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     linecook: {
				@@ -1336,21 +1469,21 @@
				             name: "linecook"
				             labels: {
				                 app:       "linecook"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "linecook"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1359,20 +1492,18 @@
				     linecook: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "linecook"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "linecook"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1389,7 +1520,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "linecook"
				                         image: "gcr.io/myproj/linecook:v0.1.42"
				                         volumeMounts: [{
				                             name:      "linecook-disk"
				@@ -1403,6 +1533,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-name=linecook", "-env=prod", "-logdir=/logs", "-event-server=events:7788", "-etcd", "etcd:2379", "-reconnect-delay", "1h", "-recovery-overlap", "100000"]
				+                        name: "linecook"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1415,8 +1546,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "linecook"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     pastrychef: {
				@@ -1426,21 +1566,21 @@
				             name: "pastrychef"
				             labels: {
				                 app:       "pastrychef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "pastrychef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1449,20 +1589,18 @@
				     pastrychef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "pastrychef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "pastrychef"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1479,7 +1617,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "pastrychef"
				                         image: "gcr.io/myproj/pastrychef:v0.1.15"
				                         volumeMounts: [{
				                             name:      "pastrychef-disk"
				@@ -1493,6 +1630,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788", "-reconnect-delay=1m", "-etcd=etcd:2379", "-recovery-overlap=10000"]
				+                        name: "pastrychef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1505,8 +1643,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "pastrychef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     souschef: {
				@@ -1516,21 +1663,21 @@
				             name: "souschef"
				             labels: {
				                 app:       "souschef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "souschef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1539,26 +1686,24 @@
				     souschef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "souschef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "souschef"
				-                        component: "kitchen"
				                         domain:    "prod"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "souschef"
				                         image: "gcr.io/myproj/souschef:v0.5.3"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "souschef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1571,11 +1716,23 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "souschef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     alertmanager: {
				@@ -1586,54 +1743,27 @@
				                 "prometheus.io/scrape": "true"
				                 "prometheus.io/path":   "/metrics"
				             }
				+            name: "alertmanager"
				             labels: {
				                 name:      "alertmanager"
				                 app:       "alertmanager"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            name: "alertmanager"
				         }
				         spec: {
				-            selector: {
				-                app:       "alertmanager"
				-                name:      "alertmanager"
				-                domain:    "prod"
				-                component: "mon"
				-            }
				             ports: [{
				-                name:       "main"
				-                protocol:   "TCP"
				                 port:       9093
				+                protocol:   "TCP"
				+                name:       "main"
				                 targetPort: 9093
				             }]
				-        }
				-    }
				-}
				-configMap: {
				-    alertmanager: {
				-        apiVersion: "v1"
				-        kind:       "ConfigMap"
				-        metadata: {
				+            selector: {
				             name: "alertmanager"
				+                app:       "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				         }
				-        data: {
				-            "alerts.yaml": """
				-                receivers:
				-                - name: pager
				-                  slack_configs:
				-                  - channel: '#cloudmon'
				-                    text: |-
				-                      {{ range .Alerts }}{{ .Annotations.description }}
				-                      {{ end }}
				-                    send_resolved: true
				-                route:
				-                  receiver: pager
				-                  group_by:
				-                  - alertname
				-                  - cluster
				-
				-                """
				         }
				     }
				 }
				@@ -1641,16 +1771,13 @@
				     alertmanager: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "alertmanager"
				-        }
				         spec: {
				-            replicas: 1
				             selector: {
				                 matchLabels: {
				                     app: "alertmanager"
				                 }
				             }
				+            replicas: 1
				             template: {
				                 metadata: {
				                     name: "alertmanager"
				@@ -1662,13 +1789,13 @@
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "alertmanager"
				                         image: "prom/alertmanager:v0.15.2"
				                         args: ["--config.file=/etc/alertmanager/alerts.yaml", "--storage.path=/alertmanager", "--web.external-url=https://alertmanager.example.com"]
				                         ports: [{
				                             name:          "alertmanager"
				                             containerPort: 9093
				                         }]
				+                        name: "alertmanager"
				                         volumeMounts: [{
				                             name:      "config-volume"
				                             mountPath: "/etc/alertmanager"
				@@ -1689,6 +1816,44 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "alertmanager"
				+            labels: {
				+                component: "mon"
				+            }
				+        }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {
				+    alertmanager: {
				+        apiVersion: "v1"
				+        kind:       "ConfigMap"
				+        data: {
				+            "alerts.yaml": """
				+                receivers:
				+                - name: pager
				+                  slack_configs:
				+                  - channel: '#cloudmon'
				+                    text: |-
				+                      {{ range .Alerts }}{{ .Annotations.description }}
				+                      {{ end }}
				+                    send_resolved: true
				+                route:
				+                  receiver: pager
				+                  group_by:
				+                  - alertname
				+                  - cluster
				+
				+                """
				+        }
				+        metadata: {
				+            name: "alertmanager"
				+            labels: {
				+                component: "mon"
				+            }
				+        }
				     }
				 }
				 // ---
				@@ -1705,17 +1870,17 @@
				             }
				         }
				         spec: {
				-            selector: {
				-                app:       "grafana"
				-                domain:    "prod"
				-                component: "mon"
				-            }
				             ports: [{
				                 name:       "grafana"
				-                protocol:   "TCP"
				                 port:       3000
				+                protocol:   "TCP"
				                 targetPort: 3000
				             }]
				+            selector: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				         }
				     }
				 }
				@@ -1724,14 +1889,15 @@
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				         metadata: {
				-            name: "grafana"
				             labels: {
				                 app:       "grafana"
				                 component: "mon"
				             }
				+            name: "grafana"
				         }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -1750,7 +1916,6 @@
				                     }]
				                     containers: [{
				                         image: "grafana/grafana:4.5.2"
				-                        name:  "grafana"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				@@ -1774,6 +1939,7 @@
				                             name:  "GF_AUTH_ANONYMOUS_ORG_ROLE"
				                             value: "admin"
				                         }]
				+                        name: "grafana"
				                         volumeMounts: [{
				                             name:      "grafana-volume"
				                             mountPath: "/var/lib/grafana"
				@@ -1784,29 +1950,33 @@
				         }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     "node-exporter": {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				+            annotations: {
				+                "prometheus.io/scrape": "true"
				+            }
				+            name: "node-exporter"
				             labels: {
				                 app:       "node-exporter"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            annotations: {
				-                "prometheus.io/scrape": "true"
				-            }
				-            name: "node-exporter"
				         }
				         spec: {
				             type:      "ClusterIP"
				             clusterIP: "None"
				             ports: [{
				-                name:     "metrics"
				                 port:     9100
				                 protocol: "TCP"
				+                name:       "metrics"
				+                targetPort: 9100
				             }]
				             selector: {
				                 app:       "node-exporter"
				@@ -1821,16 +1991,15 @@
				     "node-exporter": {
				         apiVersion: "apps/v1"
				         kind:       "DaemonSet"
				-        metadata: {
				-            name: "node-exporter"
				-        }
				         spec: {
				             template: {
				                 metadata: {
				+                    name: "node-exporter"
				                     labels: {
				                         app: "node-exporter"
				+                        component: "mon"
				+                        domain:    "prod"
				                     }
				-                    name: "node-exporter"
				                 }
				                 spec: {
				                     hostNetwork: true
				@@ -1838,7 +2007,6 @@
				                     containers: [{
				                         image: "quay.io/prometheus/node-exporter:v0.16.0"
				                         args: ["--path.procfs=/host/proc", "--path.sysfs=/host/sys"]
				-                        name: "node-exporter"
				                         ports: [{
				                             containerPort: 9100
				                             hostPort:      9100
				@@ -1854,6 +2022,7 @@
				                                 cpu:    "200m"
				                             }
				                         }
				+                        name: "node-exporter"
				                         volumeMounts: [{
				                             name:      "proc"
				                             readOnly:  true
				@@ -1877,9 +2046,18 @@
				                     }]
				                 }
				             }
				+            selector: {}
				         }
				+        metadata: {
				+            name: "node-exporter"
				+            labels: {
				+                component: "mon"
				     }
				 }
				+    }
				+}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     prometheus: {
				@@ -1889,38 +2067,99 @@
				             annotations: {
				                 "prometheus.io/scrape": "true"
				             }
				+            name: "prometheus"
				             labels: {
				                 name:      "prometheus"
				                 app:       "prometheus"
				                 domain:    "prod"
				                 component: "mon"
				             }
				+        }
				+        spec: {
				+            type: "NodePort"
				+            ports: [{
				+                port:       9090
				+                protocol:   "TCP"
				+                name:       "main"
				+                nodePort:   30900
				+                targetPort: 9090
				+            }]
				+            selector: {
				             name: "prometheus"
				+                app:       "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+        }
				+    }
				         }
				+deployment: {
				+    prometheus: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				         spec: {
				+            strategy: {
				+                rollingUpdate: {
				+                    maxSurge:       0
				+                    maxUnavailable: 1
				+                }
				+                type: "RollingUpdate"
				+            }
				             selector: {
				+                matchLabels: {
				                 app:       "prometheus"
				+                }
				+            }
				+            replicas: 1
				+            template: {
				+                metadata: {
				                 name:      "prometheus"
				+                    labels: {
				+                        app:       "prometheus"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            type: "NodePort"
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				+                }
				+                spec: {
				+                    containers: [{
				+                        image: "prom/prometheus:v2.4.3"
				+                        args: ["--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=https://prometheus.example.com"]
				             ports: [{
				-                name:     "main"
				-                protocol: "TCP"
				-                port:     9090
				-                nodePort: 30900
				+                            name:          "web"
				+                            containerPort: 9090
				+                        }]
				+                        name: "prometheus"
				+                        volumeMounts: [{
				+                            name:      "config-volume"
				+                            mountPath: "/etc/prometheus"
				+                        }]
				             }]
				+                    volumes: [{
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "prometheus"
				+                        }
				+                    }]
				+                }
				+            }
				+        }
				+        metadata: {
				+            name: "prometheus"
				+            labels: {
				+                component: "mon"
				+            }
				         }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     prometheus: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "prometheus"
				-        }
				         data: {
				             "alert.rules": """
				                 groups:
				@@ -2150,69 +2389,20 @@
				 
				                 """
				         }
				-    }
				-}
				-deployment: {
				-    prometheus: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "prometheus"
				-        }
				-        spec: {
				-            replicas: 1
				-            strategy: {
				-                rollingUpdate: {
				-                    maxSurge:       0
				-                    maxUnavailable: 1
				-                }
				-                type: "RollingUpdate"
				-            }
				-            selector: {
				-                matchLabels: {
				-                    app: "prometheus"
				-                }
				-            }
				-            template: {
				                 metadata: {
				                     name: "prometheus"
				                     labels: {
				-                        app:       "prometheus"
				-                        domain:    "prod"
				                         component: "mon"
				                     }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				-                    }
				-                }
				-                spec: {
				-                    containers: [{
				-                        name:  "prometheus"
				-                        image: "prom/prometheus:v2.4.3"
				-                        args: ["--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=https://prometheus.example.com"]
				-                        ports: [{
				-                            name:          "web"
				-                            containerPort: 9090
				-                        }]
				-                        volumeMounts: [{
				-                            name:      "config-volume"
				-                            mountPath: "/etc/prometheus"
				-                        }]
				-                    }]
				-                    volumes: [{
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "prometheus"
				-                        }
				-                    }]
				-                }
				-            }
				         }
				     }
				 }
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     authproxy: {
				@@ -2229,8 +2419,8 @@
				         spec: {
				             ports: [{
				                 port:       4180
				-                targetPort: 4180
				                 protocol:   "TCP"
				+                targetPort: 4180
				                 name:       "client"
				             }]
				             selector: {
				@@ -2245,11 +2435,9 @@
				     authproxy: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "authproxy"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2260,12 +2448,12 @@
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "authproxy"
				                         image: "skippy/oauth2_proxy:2.0.1"
				                         ports: [{
				                             containerPort: 4180
				                         }]
				                         args: ["--config=/etc/authproxy/authproxy.cfg"]
				+                        name: "authproxy"
				                         volumeMounts: [{
				                             name:      "config-volume"
				                             mountPath: "/etc/authproxy"
				@@ -2280,15 +2468,20 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                component: "proxy"
				+            }
				     }
				 }
				+}
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     authproxy: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "authproxy"
				-        }
				         data: {
				             "authproxy.cfg": """
				                 # Google Auth Proxy Config File
				@@ -2344,6 +2537,12 @@
				                 cookie_https_only = true
				                 """
				         }
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }
				 // ---
				@@ -2364,9 +2563,9 @@
				             loadBalancerIP: "1.3.5.7"
				             ports: [{
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "https"
				+                targetPort: 7443
				             }]
				             selector: {
				                 app:       "goget"
				@@ -2380,11 +2579,9 @@
				     goget: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "goget"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2401,11 +2598,11 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "goget"
				                         image: "gcr.io/myproj/goget:v0.5.1"
				                         ports: [{
				                             containerPort: 7443
				                         }]
				+                        name: "goget"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -2414,8 +2611,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "goget"
				+            labels: {
				+                component: "proxy"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     nginx: {
				@@ -2434,13 +2640,14 @@
				             loadBalancerIP: "1.3.4.5"
				             ports: [{
				                 port:       80
				-                targetPort: 80
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 80
				             }, {
				                 port:     443
				                 protocol: "TCP"
				                 name:     "https"
				+                targetPort: 443
				             }]
				             selector: {
				                 app:       "nginx"
				@@ -2454,11 +2661,9 @@
				     nginx: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "nginx"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2480,13 +2685,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "nginx"
				                         image: "nginx:1.11.10-alpine"
				                         ports: [{
				                             containerPort: 80
				                         }, {
				                             containerPort: 443
				                         }]
				+                        name: "nginx"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -2499,15 +2704,20 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "nginx"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     nginx: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "nginx"
				-        }
				         data: {
				             "nginx.conf": """
				                 events {
				@@ -2664,5 +2874,11 @@
				                 }
				                 """
				         }
				+        metadata: {
				+            name: "nginx"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }

				"""#
			ComparisonOutput: #"""
				--- snapshot\#t2021-05-28 16:42:14.198578533 +0000
				+++ snapshot2\#t2021-05-28 16:42:36.449947811 +0000
				@@ -1,8 +1,14 @@
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     bartender: {
				@@ -11,22 +17,22 @@
				         metadata: {
				             name: "bartender"
				             labels: {
				-                component: "frontend"
				                 app:       "bartender"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				-                component: "frontend"
				                 app:       "bartender"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -35,37 +41,44 @@
				     bartender: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "bartender"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        component: "frontend"
				-                        app:       "bartender"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "bartender"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "bartender"
				                         image: "gcr.io/myproj/bartender:v0.1.34"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "bartender"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "bartender"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     breaddispatcher: {
				@@ -75,21 +88,21 @@
				             name: "breaddispatcher"
				             labels: {
				                 app:       "breaddispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "breaddispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -98,37 +111,44 @@
				     breaddispatcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "breaddispatcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "breaddispatcher"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "breaddispatcher"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "breaddispatcher"
				                         image: "gcr.io/myproj/breaddispatcher:v0.3.24"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "breaddispatcher"
				                         args: ["-etcd=etcd:2379", "-event-server=events:7788"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "breaddispatcher"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     host: {
				@@ -138,21 +158,21 @@
				             name: "host"
				             labels: {
				                 app:       "host"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "host"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -161,36 +181,44 @@
				     host: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "host"
				-        }
				         spec: {
				             replicas: 2
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "7080"
				+                    }
				                     labels: {
				                         app:       "host"
				-                        component: "frontend"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "frontend"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "host"
				                         image: "gcr.io/myproj/host:v0.1.10"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "host"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "host"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     maitred: {
				@@ -200,15 +228,15 @@
				             name: "maitred"
				             labels: {
				                 app:       "maitred"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				@@ -223,37 +251,44 @@
				     maitred: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "maitred"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "maitred"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "maitred"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "maitred"
				                         image: "gcr.io/myproj/maitred:v0.0.4"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "maitred"
				                         args: []
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "maitred"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     valeter: {
				@@ -262,17 +297,17 @@
				         metadata: {
				             name: "valeter"
				             labels: {
				-                component: "frontend"
				                 app:       "valeter"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 8080
				             }]
				             selector: {
				                 app:       "valeter"
				@@ -286,36 +321,44 @@
				     valeter: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "valeter"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "8080"
				+                    }
				                     labels: {
				-                        component: "frontend"
				                         app:       "valeter"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "frontend"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "valeter"
				                         image: "gcr.io/myproj/valeter:v0.0.4"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "valeter"
				                         args: ["-http=:8080", "-etcd=etcd:2379"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "valeter"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     waiter: {
				@@ -324,22 +367,22 @@
				         metadata: {
				             name: "waiter"
				             labels: {
				-                component: "frontend"
				                 app:       "waiter"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "waiter"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -348,27 +391,25 @@
				     waiter: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "waiter"
				-        }
				         spec: {
				             replicas: 5
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        component: "frontend"
				-                        app:       "waiter"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "waiter"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "waiter"
				                         image: "gcr.io/myproj/waiter:v0.3.0"
				+                        name:  "waiter"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				@@ -376,8 +417,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "waiter"
				+            labels: {
				+                component: "frontend"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     waterdispatcher: {
				@@ -387,21 +437,21 @@
				             name: "waterdispatcher"
				             labels: {
				                 app:       "waterdispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7080
				             }]
				             selector: {
				                 app:       "waterdispatcher"
				-                component: "frontend"
				                 domain:    "prod"
				+                component: "frontend"
				             }
				         }
				     }
				@@ -410,40 +460,50 @@
				     waterdispatcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "waterdispatcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "waterdispatcher"
				-                        component: "frontend"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "waterdispatcher"
				+                        domain:    "prod"
				+                        component: "frontend"
				+                    }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "waterdispatcher"
				                         image: "gcr.io/myproj/waterdispatcher:v0.0.48"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				+                        name: "waterdispatcher"
				                         args: ["-http=:8080", "-etcd=etcd:2379"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "waterdispatcher"
				+            labels: {
				+                component: "frontend"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     download: {
				@@ -453,15 +513,15 @@
				             name: "download"
				             labels: {
				                 app:       "download"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7080
				-                targetPort: 7080
				                 protocol:   "TCP"
				+                targetPort: 7080
				                 name:       "client"
				             }]
				             selector: {
				@@ -476,23 +536,21 @@
				     download: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "download"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "download"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "download"
				                         image: "gcr.io/myproj/download:v0.0.2"
				+                        name:  "download"
				                         ports: [{
				                             containerPort: 7080
				                         }]
				@@ -500,8 +558,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "download"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     etcd: {
				@@ -517,46 +584,45 @@
				         }
				         spec: {
				             clusterIP: "None"
				-            selector: {
				-                app:       "etcd"
				-                domain:    "prod"
				-                component: "infra"
				-            }
				             ports: [{
				                 port:       2379
				-                targetPort: 2379
				                 protocol:   "TCP"
				+                targetPort: 2379
				                 name:       "client"
				             }, {
				                 port:       2380
				-                targetPort: 2380
				                 protocol:   "TCP"
				                 name:       "peer"
				+                targetPort: 2380
				             }]
				+            selector: {
				+                app:       "etcd"
				+                domain:    "prod"
				+                component: "infra"
				+            }
				         }
				     }
				 }
				 deployment: {}
				+daemonSet: {}
				 statefulSet: {
				     etcd: {
				         apiVersion: "apps/v1"
				         kind:       "StatefulSet"
				-        metadata: {
				-            name: "etcd"
				-        }
				         spec: {
				             serviceName: "etcd"
				             replicas:    3
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "etcd"
				-                        component: "infra"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "2379"
				                     }
				+                    labels: {
				+                        app:       "etcd"
				+                        component: "infra"
				+                        domain:    "prod"
				+                    }
				                 }
				                 spec: {
				                     affinity: {
				@@ -575,7 +641,6 @@
				                     }
				                     terminationGracePeriodSeconds: 10
				                     containers: [{
				-                        name:  "etcd"
				                         image: "quay.io/coreos/etcd:v3.3.10"
				                         ports: [{
				                             name:          "client"
				@@ -617,10 +682,12 @@
				                             }
				                         }]
				                         command: ["/usr/local/bin/etcd"]
				+                        name: "etcd"
				                         args: ["-name", "$(NAME)", "-data-dir", "/data/etcd3", "-initial-advertise-peer-urls", "http://$(IP):2380", "-listen-peer-urls", "http://$(IP):2380", "-listen-client-urls", "http://$(IP):2379,http://127.0.0.1:2379", "-advertise-client-urls", "http://$(IP):2379", "-discovery", "https://discovery.etcd.io/xxxxxx"]
				                     }]
				                 }
				             }
				+            selector: {}
				             volumeClaimTemplates: [{
				                 metadata: {
				                     name: "etcd3"
				@@ -638,8 +705,15 @@
				                 }
				             }]
				         }
				+        metadata: {
				+            name: "etcd"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+configMap: {}
				 // ---
				 service: {
				     events: {
				@@ -649,21 +723,21 @@
				             name: "events"
				             labels: {
				                 app:       "events"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       7788
				-                targetPort: 7788
				                 protocol:   "TCP"
				                 name:       "grpc"
				+                targetPort: 7788
				             }]
				             selector: {
				                 app:       "events"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -672,22 +746,20 @@
				     events: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "events"
				-        }
				         spec: {
				             replicas: 2
				+            selector: {}
				             template: {
				                 metadata: {
				-                    labels: {
				-                        app:       "events"
				-                        component: "infra"
				-                        domain:    "prod"
				-                    }
				                     annotations: {
				                         "prometheus.io.scrape": "true"
				                         "prometheus.io.port":   "7080"
				                     }
				+                    labels: {
				+                        app:       "events"
				+                        domain:    "prod"
				+                        component: "infra"
				+                    }
				                 }
				                 spec: {
				                     affinity: {
				@@ -711,7 +783,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "events"
				                         image: "gcr.io/myproj/events:v0.1.31"
				                         ports: [{
				                             containerPort: 7080
				@@ -719,6 +790,7 @@
				                             containerPort: 7788
				                         }]
				                         args: ["-cert=/etc/ssl/server.pem", "-key=/etc/ssl/server.key", "-grpc=:7788"]
				+                        name: "events"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -727,8 +799,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "events"
				+            labels: {
				+                component: "infra"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     tasks: {
				@@ -747,9 +828,9 @@
				             loadBalancerIP: "1.2.3.4"
				             ports: [{
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7443
				             }]
				             selector: {
				                 app:       "tasks"
				@@ -763,22 +844,20 @@
				     tasks: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "tasks"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                        "prometheus.io.port":   "7080"
				+                    }
				                     labels: {
				                         app:       "tasks"
				                         domain:    "prod"
				                         component: "infra"
				                     }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				-                        "prometheus.io.port":   "7080"
				-                    }
				                 }
				                 spec: {
				                     volumes: [{
				@@ -788,13 +867,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "tasks"
				                         image: "gcr.io/myproj/tasks:v0.2.6"
				                         ports: [{
				                             containerPort: 7080
				                         }, {
				                             containerPort: 7443
				                         }]
				+                        name: "tasks"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -803,8 +882,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "tasks"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     updater: {
				@@ -814,15 +902,15 @@
				             name: "updater"
				             labels: {
				                 app:       "updater"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				@@ -837,17 +925,15 @@
				     updater: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "updater"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "updater"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				@@ -858,7 +944,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "updater"
				                         image: "gcr.io/myproj/updater:v0.1.0"
				                         volumeMounts: [{
				                             mountPath: "/etc/certs"
				@@ -867,13 +952,23 @@
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "updater"
				                         args: ["-key=/etc/certs/updater.pem"]
				                     }]
				                 }
				             }
				         }
				+        metadata: {
				+            name: "updater"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     watcher: {
				@@ -883,8 +978,8 @@
				             name: "watcher"
				             labels: {
				                 app:       "watcher"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				         spec: {
				@@ -892,14 +987,14 @@
				             loadBalancerIP: "1.2.3.4."
				             ports: [{
				                 port:       7788
				-                targetPort: 7788
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 7788
				             }]
				             selector: {
				                 app:       "watcher"
				-                component: "infra"
				                 domain:    "prod"
				+                component: "infra"
				             }
				         }
				     }
				@@ -908,17 +1003,15 @@
				     watcher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "watcher"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "watcher"
				-                        component: "infra"
				                         domain:    "prod"
				+                        component: "infra"
				                     }
				                 }
				                 spec: {
				@@ -929,13 +1022,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "watcher"
				                         image: "gcr.io/myproj/watcher:v0.1.0"
				                         ports: [{
				                             containerPort: 7080
				                         }, {
				                             containerPort: 7788
				                         }]
				+                        name: "watcher"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -944,11 +1037,23 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "watcher"
				+            labels: {
				+                component: "infra"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     caller: {
				@@ -958,15 +1063,15 @@
				             name: "caller"
				             labels: {
				                 app:       "caller"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				@@ -981,20 +1086,18 @@
				     caller: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "caller"
				-        }
				         spec: {
				             replicas: 3
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "caller"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1016,7 +1119,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "caller"
				                         image: "gcr.io/myproj/caller:v0.20.14"
				                         volumeMounts: [{
				                             name:      "ssd-caller"
				@@ -1034,6 +1136,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-key=/etc/certs/client.key", "-cert=/etc/certs/client.pem", "-ca=/etc/certs/servfx.ca", "-ssh-tunnel-key=/sslcerts/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "caller"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1046,8 +1149,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "caller"
				+            labels: {
				+                component: "kitchen"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     dishwasher: {
				@@ -1057,21 +1169,21 @@
				             name: "dishwasher"
				             labels: {
				                 app:       "dishwasher"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "dishwasher"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1080,20 +1192,18 @@
				     dishwasher: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "dishwasher"
				-        }
				         spec: {
				             replicas: 5
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "dishwasher"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1115,7 +1225,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "dishwasher"
				                         image: "gcr.io/myproj/dishwasher:v0.2.13"
				                         volumeMounts: [{
				                             name:      "dishwasher-disk"
				@@ -1133,6 +1242,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "dishwasher"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1145,8 +1255,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "dishwasher"
				+            labels: {
				+                component: "kitchen"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     expiditer: {
				@@ -1156,21 +1275,21 @@
				             name: "expiditer"
				             labels: {
				                 app:       "expiditer"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "expiditer"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1179,20 +1298,18 @@
				     expiditer: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "expiditer"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "expiditer"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1209,7 +1326,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "expiditer"
				                         image: "gcr.io/myproj/expiditer:v0.5.34"
				                         volumeMounts: [{
				                             name:      "expiditer-disk"
				@@ -1223,6 +1339,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "expiditer"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1235,8 +1352,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "expiditer"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     headchef: {
				@@ -1246,21 +1372,21 @@
				             name: "headchef"
				             labels: {
				                 app:       "headchef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "headchef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1269,20 +1395,18 @@
				     headchef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "headchef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "headchef"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1299,7 +1423,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "headchef"
				                         image: "gcr.io/myproj/headchef:v0.2.16"
				                         volumeMounts: [{
				                             name:      "headchef-disk"
				@@ -1313,6 +1436,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-logdir=/logs", "-event-server=events:7788"]
				+                        name: "headchef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1325,8 +1449,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "headchef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     linecook: {
				@@ -1336,21 +1469,21 @@
				             name: "linecook"
				             labels: {
				                 app:       "linecook"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "linecook"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1359,20 +1492,18 @@
				     linecook: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "linecook"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "linecook"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1389,7 +1520,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "linecook"
				                         image: "gcr.io/myproj/linecook:v0.1.42"
				                         volumeMounts: [{
				                             name:      "linecook-disk"
				@@ -1403,6 +1533,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-name=linecook", "-env=prod", "-logdir=/logs", "-event-server=events:7788", "-etcd", "etcd:2379", "-reconnect-delay", "1h", "-recovery-overlap", "100000"]
				+                        name: "linecook"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1415,8 +1546,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "linecook"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     pastrychef: {
				@@ -1426,21 +1566,21 @@
				             name: "pastrychef"
				             labels: {
				                 app:       "pastrychef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "pastrychef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1449,20 +1589,18 @@
				     pastrychef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "pastrychef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				                     labels: {
				                         app:       "pastrychef"
				-                        component: "kitchen"
				                         domain:    "prod"
				-                    }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				@@ -1479,7 +1617,6 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "pastrychef"
				                         image: "gcr.io/myproj/pastrychef:v0.1.15"
				                         volumeMounts: [{
				                             name:      "pastrychef-disk"
				@@ -1493,6 +1630,7 @@
				                             containerPort: 8080
				                         }]
				                         args: ["-env=prod", "-ssh-tunnel-key=/etc/certs/tunnel-private.pem", "-logdir=/logs", "-event-server=events:7788", "-reconnect-delay=1m", "-etcd=etcd:2379", "-recovery-overlap=10000"]
				+                        name: "pastrychef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1505,8 +1643,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "pastrychef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     souschef: {
				@@ -1516,21 +1663,21 @@
				             name: "souschef"
				             labels: {
				                 app:       "souschef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				         spec: {
				             ports: [{
				                 port:       8080
				-                targetPort: 8080
				                 protocol:   "TCP"
				+                targetPort: 8080
				                 name:       "client"
				             }]
				             selector: {
				                 app:       "souschef"
				-                component: "kitchen"
				                 domain:    "prod"
				+                component: "kitchen"
				             }
				         }
				     }
				@@ -1539,26 +1686,24 @@
				     souschef: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "souschef"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				                         app:       "souschef"
				-                        component: "kitchen"
				                         domain:    "prod"
				+                        component: "kitchen"
				                     }
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "souschef"
				                         image: "gcr.io/myproj/souschef:v0.5.3"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				+                        name: "souschef"
				                         livenessProbe: {
				                             httpGet: {
				                                 path: "/debug/health"
				@@ -1571,11 +1716,23 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "souschef"
				+            labels: {
				+                component: "kitchen"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     alertmanager: {
				@@ -1586,54 +1743,27 @@
				                 "prometheus.io/scrape": "true"
				                 "prometheus.io/path":   "/metrics"
				             }
				+            name: "alertmanager"
				             labels: {
				                 name:      "alertmanager"
				                 app:       "alertmanager"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            name: "alertmanager"
				         }
				         spec: {
				-            selector: {
				-                app:       "alertmanager"
				-                name:      "alertmanager"
				-                domain:    "prod"
				-                component: "mon"
				-            }
				             ports: [{
				-                name:       "main"
				-                protocol:   "TCP"
				                 port:       9093
				+                protocol:   "TCP"
				+                name:       "main"
				                 targetPort: 9093
				             }]
				-        }
				-    }
				-}
				-configMap: {
				-    alertmanager: {
				-        apiVersion: "v1"
				-        kind:       "ConfigMap"
				-        metadata: {
				+            selector: {
				             name: "alertmanager"
				+                app:       "alertmanager"
				+                domain:    "prod"
				+                component: "mon"
				         }
				-        data: {
				-            "alerts.yaml": """
				-                receivers:
				-                - name: pager
				-                  slack_configs:
				-                  - channel: '#cloudmon'
				-                    text: |-
				-                      {{ range .Alerts }}{{ .Annotations.description }}
				-                      {{ end }}
				-                    send_resolved: true
				-                route:
				-                  receiver: pager
				-                  group_by:
				-                  - alertname
				-                  - cluster
				-
				-                """
				         }
				     }
				 }
				@@ -1641,16 +1771,13 @@
				     alertmanager: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "alertmanager"
				-        }
				         spec: {
				-            replicas: 1
				             selector: {
				                 matchLabels: {
				                     app: "alertmanager"
				                 }
				             }
				+            replicas: 1
				             template: {
				                 metadata: {
				                     name: "alertmanager"
				@@ -1662,13 +1789,13 @@
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "alertmanager"
				                         image: "prom/alertmanager:v0.15.2"
				                         args: ["--config.file=/etc/alertmanager/alerts.yaml", "--storage.path=/alertmanager", "--web.external-url=https://alertmanager.example.com"]
				                         ports: [{
				                             name:          "alertmanager"
				                             containerPort: 9093
				                         }]
				+                        name: "alertmanager"
				                         volumeMounts: [{
				                             name:      "config-volume"
				                             mountPath: "/etc/alertmanager"
				@@ -1689,6 +1816,44 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "alertmanager"
				+            labels: {
				+                component: "mon"
				+            }
				+        }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {
				+    alertmanager: {
				+        apiVersion: "v1"
				+        kind:       "ConfigMap"
				+        data: {
				+            "alerts.yaml": """
				+                receivers:
				+                - name: pager
				+                  slack_configs:
				+                  - channel: '#cloudmon'
				+                    text: |-
				+                      {{ range .Alerts }}{{ .Annotations.description }}
				+                      {{ end }}
				+                    send_resolved: true
				+                route:
				+                  receiver: pager
				+                  group_by:
				+                  - alertname
				+                  - cluster
				+
				+                """
				+        }
				+        metadata: {
				+            name: "alertmanager"
				+            labels: {
				+                component: "mon"
				+            }
				+        }
				     }
				 }
				 // ---
				@@ -1705,17 +1870,17 @@
				             }
				         }
				         spec: {
				-            selector: {
				-                app:       "grafana"
				-                domain:    "prod"
				-                component: "mon"
				-            }
				             ports: [{
				                 name:       "grafana"
				-                protocol:   "TCP"
				                 port:       3000
				+                protocol:   "TCP"
				                 targetPort: 3000
				             }]
				+            selector: {
				+                app:       "grafana"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				         }
				     }
				 }
				@@ -1724,14 +1889,15 @@
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				         metadata: {
				-            name: "grafana"
				             labels: {
				                 app:       "grafana"
				                 component: "mon"
				             }
				+            name: "grafana"
				         }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -1750,7 +1916,6 @@
				                     }]
				                     containers: [{
				                         image: "grafana/grafana:4.5.2"
				-                        name:  "grafana"
				                         ports: [{
				                             containerPort: 8080
				                         }]
				@@ -1774,6 +1939,7 @@
				                             name:  "GF_AUTH_ANONYMOUS_ORG_ROLE"
				                             value: "admin"
				                         }]
				+                        name: "grafana"
				                         volumeMounts: [{
				                             name:      "grafana-volume"
				                             mountPath: "/var/lib/grafana"
				@@ -1784,29 +1950,33 @@
				         }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     "node-exporter": {
				         apiVersion: "v1"
				         kind:       "Service"
				         metadata: {
				+            annotations: {
				+                "prometheus.io/scrape": "true"
				+            }
				+            name: "node-exporter"
				             labels: {
				                 app:       "node-exporter"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            annotations: {
				-                "prometheus.io/scrape": "true"
				-            }
				-            name: "node-exporter"
				         }
				         spec: {
				             type:      "ClusterIP"
				             clusterIP: "None"
				             ports: [{
				-                name:     "metrics"
				                 port:     9100
				                 protocol: "TCP"
				+                name:       "metrics"
				+                targetPort: 9100
				             }]
				             selector: {
				                 app:       "node-exporter"
				@@ -1821,16 +1991,15 @@
				     "node-exporter": {
				         apiVersion: "apps/v1"
				         kind:       "DaemonSet"
				-        metadata: {
				-            name: "node-exporter"
				-        }
				         spec: {
				             template: {
				                 metadata: {
				+                    name: "node-exporter"
				                     labels: {
				                         app: "node-exporter"
				+                        component: "mon"
				+                        domain:    "prod"
				                     }
				-                    name: "node-exporter"
				                 }
				                 spec: {
				                     hostNetwork: true
				@@ -1838,7 +2007,6 @@
				                     containers: [{
				                         image: "quay.io/prometheus/node-exporter:v0.16.0"
				                         args: ["--path.procfs=/host/proc", "--path.sysfs=/host/sys"]
				-                        name: "node-exporter"
				                         ports: [{
				                             containerPort: 9100
				                             hostPort:      9100
				@@ -1854,6 +2022,7 @@
				                                 cpu:    "200m"
				                             }
				                         }
				+                        name: "node-exporter"
				                         volumeMounts: [{
				                             name:      "proc"
				                             readOnly:  true
				@@ -1877,9 +2046,18 @@
				                     }]
				                 }
				             }
				+            selector: {}
				         }
				+        metadata: {
				+            name: "node-exporter"
				+            labels: {
				+                component: "mon"
				     }
				 }
				+    }
				+}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     prometheus: {
				@@ -1889,38 +2067,99 @@
				             annotations: {
				                 "prometheus.io/scrape": "true"
				             }
				+            name: "prometheus"
				             labels: {
				                 name:      "prometheus"
				                 app:       "prometheus"
				                 domain:    "prod"
				                 component: "mon"
				             }
				+        }
				+        spec: {
				+            type: "NodePort"
				+            ports: [{
				+                port:       9090
				+                protocol:   "TCP"
				+                name:       "main"
				+                nodePort:   30900
				+                targetPort: 9090
				+            }]
				+            selector: {
				             name: "prometheus"
				+                app:       "prometheus"
				+                domain:    "prod"
				+                component: "mon"
				+            }
				+        }
				+    }
				         }
				+deployment: {
				+    prometheus: {
				+        apiVersion: "apps/v1"
				+        kind:       "Deployment"
				         spec: {
				+            strategy: {
				+                rollingUpdate: {
				+                    maxSurge:       0
				+                    maxUnavailable: 1
				+                }
				+                type: "RollingUpdate"
				+            }
				             selector: {
				+                matchLabels: {
				                 app:       "prometheus"
				+                }
				+            }
				+            replicas: 1
				+            template: {
				+                metadata: {
				                 name:      "prometheus"
				+                    labels: {
				+                        app:       "prometheus"
				                 domain:    "prod"
				                 component: "mon"
				             }
				-            type: "NodePort"
				+                    annotations: {
				+                        "prometheus.io.scrape": "true"
				+                    }
				+                }
				+                spec: {
				+                    containers: [{
				+                        image: "prom/prometheus:v2.4.3"
				+                        args: ["--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=https://prometheus.example.com"]
				             ports: [{
				-                name:     "main"
				-                protocol: "TCP"
				-                port:     9090
				-                nodePort: 30900
				+                            name:          "web"
				+                            containerPort: 9090
				+                        }]
				+                        name: "prometheus"
				+                        volumeMounts: [{
				+                            name:      "config-volume"
				+                            mountPath: "/etc/prometheus"
				+                        }]
				             }]
				+                    volumes: [{
				+                        name: "config-volume"
				+                        configMap: {
				+                            name: "prometheus"
				+                        }
				+                    }]
				+                }
				+            }
				+        }
				+        metadata: {
				+            name: "prometheus"
				+            labels: {
				+                component: "mon"
				+            }
				         }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     prometheus: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "prometheus"
				-        }
				         data: {
				             "alert.rules": """
				                 groups:
				@@ -2150,69 +2389,20 @@
				 
				                 """
				         }
				-    }
				-}
				-deployment: {
				-    prometheus: {
				-        apiVersion: "apps/v1"
				-        kind:       "Deployment"
				-        metadata: {
				-            name: "prometheus"
				-        }
				-        spec: {
				-            replicas: 1
				-            strategy: {
				-                rollingUpdate: {
				-                    maxSurge:       0
				-                    maxUnavailable: 1
				-                }
				-                type: "RollingUpdate"
				-            }
				-            selector: {
				-                matchLabels: {
				-                    app: "prometheus"
				-                }
				-            }
				-            template: {
				                 metadata: {
				                     name: "prometheus"
				                     labels: {
				-                        app:       "prometheus"
				-                        domain:    "prod"
				                         component: "mon"
				                     }
				-                    annotations: {
				-                        "prometheus.io.scrape": "true"
				-                    }
				-                }
				-                spec: {
				-                    containers: [{
				-                        name:  "prometheus"
				-                        image: "prom/prometheus:v2.4.3"
				-                        args: ["--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=https://prometheus.example.com"]
				-                        ports: [{
				-                            name:          "web"
				-                            containerPort: 9090
				-                        }]
				-                        volumeMounts: [{
				-                            name:      "config-volume"
				-                            mountPath: "/etc/prometheus"
				-                        }]
				-                    }]
				-                    volumes: [{
				-                        name: "config-volume"
				-                        configMap: {
				-                            name: "prometheus"
				-                        }
				-                    }]
				-                }
				-            }
				         }
				     }
				 }
				 // ---
				 service: {}
				 deployment: {}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     authproxy: {
				@@ -2229,8 +2419,8 @@
				         spec: {
				             ports: [{
				                 port:       4180
				-                targetPort: 4180
				                 protocol:   "TCP"
				+                targetPort: 4180
				                 name:       "client"
				             }]
				             selector: {
				@@ -2245,11 +2435,9 @@
				     authproxy: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "authproxy"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2260,12 +2448,12 @@
				                 }
				                 spec: {
				                     containers: [{
				-                        name:  "authproxy"
				                         image: "skippy/oauth2_proxy:2.0.1"
				                         ports: [{
				                             containerPort: 4180
				                         }]
				                         args: ["--config=/etc/authproxy/authproxy.cfg"]
				+                        name: "authproxy"
				                         volumeMounts: [{
				                             name:      "config-volume"
				                             mountPath: "/etc/authproxy"
				@@ -2280,15 +2468,20 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                component: "proxy"
				+            }
				     }
				 }
				+}
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     authproxy: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "authproxy"
				-        }
				         data: {
				             "authproxy.cfg": """
				                 # Google Auth Proxy Config File
				@@ -2344,6 +2537,12 @@
				                 cookie_https_only = true
				                 """
				         }
				+        metadata: {
				+            name: "authproxy"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }
				 // ---
				@@ -2364,9 +2563,9 @@
				             loadBalancerIP: "1.3.5.7"
				             ports: [{
				                 port:       443
				-                targetPort: 7443
				                 protocol:   "TCP"
				                 name:       "https"
				+                targetPort: 7443
				             }]
				             selector: {
				                 app:       "goget"
				@@ -2380,11 +2579,9 @@
				     goget: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "goget"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2401,11 +2598,11 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "goget"
				                         image: "gcr.io/myproj/goget:v0.5.1"
				                         ports: [{
				                             containerPort: 7443
				                         }]
				+                        name: "goget"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -2414,8 +2611,17 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "goget"
				+            labels: {
				+                component: "proxy"
				     }
				 }
				+    }
				+}
				+daemonSet: {}
				+statefulSet: {}
				+configMap: {}
				 // ---
				 service: {
				     nginx: {
				@@ -2434,13 +2640,14 @@
				             loadBalancerIP: "1.3.4.5"
				             ports: [{
				                 port:       80
				-                targetPort: 80
				                 protocol:   "TCP"
				                 name:       "http"
				+                targetPort: 80
				             }, {
				                 port:     443
				                 protocol: "TCP"
				                 name:     "https"
				+                targetPort: 443
				             }]
				             selector: {
				                 app:       "nginx"
				@@ -2454,11 +2661,9 @@
				     nginx: {
				         apiVersion: "apps/v1"
				         kind:       "Deployment"
				-        metadata: {
				-            name: "nginx"
				-        }
				         spec: {
				             replicas: 1
				+            selector: {}
				             template: {
				                 metadata: {
				                     labels: {
				@@ -2480,13 +2685,13 @@
				                         }
				                     }]
				                     containers: [{
				-                        name:  "nginx"
				                         image: "nginx:1.11.10-alpine"
				                         ports: [{
				                             containerPort: 80
				                         }, {
				                             containerPort: 443
				                         }]
				+                        name: "nginx"
				                         volumeMounts: [{
				                             mountPath: "/etc/ssl"
				                             name:      "secret-volume"
				@@ -2499,15 +2704,20 @@
				                 }
				             }
				         }
				+        metadata: {
				+            name: "nginx"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }
				+daemonSet: {}
				+statefulSet: {}
				 configMap: {
				     nginx: {
				         apiVersion: "v1"
				         kind:       "ConfigMap"
				-        metadata: {
				-            name: "nginx"
				-        }
				         data: {
				             "nginx.conf": """
				                 events {
				@@ -2664,5 +2874,11 @@
				                 }
				                 """
				         }
				+        metadata: {
				+            name: "nginx"
				+            labels: {
				+                component: "proxy"
				+            }
				+        }
				     }
				 }

				"""#
		}, {
			Negated:          false
			CmdStr:           "cp snapshot2 snapshot"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cue_trim_simplify_frontend: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_trim_simplify_frontend"
		Order:           32
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue trim -s ./frontend/..."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				 1062  2156 20748 total

				"""
			ComparisonOutput: """
				 1062  2156 20748 total

				"""
		}]
	}
	simplify_kitchen: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "simplify_kitchen"
		Order:           33
		Terminal:        "term1"
		Stmts: [{
			Negated: false
			CmdStr: """
				cat <<EOF >>kitchen/kube.cue

				deployment: [string]: spec: template: {
				\tmetadata: annotations: "prometheus.io.scrape": "true"
				\tspec: containers: [{
				\t\tports: [{
				\t\t\tcontainerPort: 8080
				\t\t}]
				\t\tlivenessProbe: {
				\t\t\thttpGet: {
				\t\t\t\tpath: "/debug/health"
				\t\t\t\tport: 8080
				\t\t\t}
				\t\t\tinitialDelaySeconds: 40
				\t\t\tperiodSeconds:       3
				\t\t}
				\t}]
				}
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cue fmt ./kitchen"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	simplify_kitchen_part2: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "simplify_kitchen_part2"
		Order:           34
		Terminal:        "term1"
		Stmts: [{
			Negated: false
			CmdStr: """
				cat <<EOF >>kitchen/kube.cue

				deployment: [ID=_]: spec: template: spec: {
				\t_hasDisks: *true | bool

				\t// field comprehension using just "if"
				\tif _hasDisks {
				\t\tvolumes: [{
				\t\t\tname: *"\\(ID)-disk" | string
				\t\t\tgcePersistentDisk: pdName: *"\\(ID)-disk" | string
				\t\t\tgcePersistentDisk: fsType: "ext4"
				\t\t}, {
				\t\t\tname: *"secret-\\(ID)" | string
				\t\t\tsecret: secretName: *"\\(ID)-secrets" | string
				\t\t}, ...]

				\t\tcontainers: [{
				\t\t\tvolumeMounts: [{
				\t\t\t\tname:      *"\\(ID)-disk" | string
				\t\t\t\tmountPath: *"/logs" | string
				\t\t\t}, {
				\t\t\t\tmountPath: *"/etc/certs" | string
				\t\t\t\tname:      *"secret-\\(ID)" | string
				\t\t\t\treadOnly:  true
				\t\t\t}, ...]
				\t\t}]
				\t}
				}
				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cue fmt ./kitchen"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated: false
			CmdStr: """
				cat <<EOF >>kitchen/souschef/kube.cue

				deployment: souschef: spec: template: spec: {
				\t _hasDisks: false
				}

				EOF
				"""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cue fmt ./kitchen/..."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	cue_trim_and_check_kitchen: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cue_trim_and_check_kitchen"
		Order:           35
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cue trim -s ./kitchen/..."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cue eval ./... >snapshot2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  true
			CmdStr:   "diff snapshot snapshot2"
			ExitCode: 1
			Output: """
				2a3
				> #Component: string
				8a10
				> #Component: "frontend"
				49,52d50
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				57a56,59
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				61a64
				>                         name:  "bartender"
				65d67
				<                         name: "bartender"
				78a81
				> #Component: "frontend"
				119,122d121
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				127a127,130
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				131a135
				>                         name:  "breaddispatcher"
				135d138
				<                         name: "breaddispatcher"
				148a152
				> #Component: "frontend"
				189,192d192
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				197a198,201
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				201a206
				>                         name:  "host"
				205d209
				<                         name: "host"
				218a223
				> #Component: "frontend"
				259,262d263
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				267a269,272
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				271a277
				>                         name:  "maitred"
				275d280
				<                         name: "maitred"
				288a294
				> #Component: "frontend"
				329,332d334
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "8080"
				<                     }
				337a340,343
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "8080"
				>                     }
				358a365
				> #Component: "frontend"
				399,402d405
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				407a411,414
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				427a435
				> #Component: "frontend"
				468,471d475
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				476a481,484
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				480a489
				>                         name:  "waterdispatcher"
				484d492
				<                         name: "waterdispatcher"
				497a506
				> #Component: "frontend"
				503a513
				> #Component: "infra"
				568a579
				> #Component: "infra"
				606a618
				> #Component: "infra"
				809a822
				> #Component: "infra"
				892a906
				> #Component: "infra"
				968a983
				> #Component: "infra"
				1047a1063
				> #Component: "infra"
				1053a1070
				> #Component: "kitchen"
				1094,1096d1110
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1101a1116,1118
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1134a1152
				>                         name: "caller"
				1139d1156
				<                         name: "caller"
				1159a1177
				> #Component: "kitchen"
				1200,1202d1217
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1207a1223,1225
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1240a1259
				>                         name: "dishwasher"
				1245d1263
				<                         name: "dishwasher"
				1265a1284
				> #Component: "kitchen"
				1306,1308d1324
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1313a1330,1332
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1329a1349,1352
				>                         name:  "expiditer"
				>                         ports: [{
				>                             containerPort: 8080
				>                         }]
				1338,1340d1360
				<                         ports: [{
				<                             containerPort: 8080
				<                         }]
				1342d1361
				<                         name: "expiditer"
				1362a1382
				> #Component: "kitchen"
				1403,1405d1422
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1410a1428,1430
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1434a1455
				>                         name: "headchef"
				1439d1459
				<                         name: "headchef"
				1459a1480
				> #Component: "kitchen"
				1500,1502d1520
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1507a1526,1528
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1531a1553
				>                         name: "linecook"
				1536d1557
				<                         name: "linecook"
				1556a1578
				> #Component: "kitchen"
				1597,1599d1618
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1604a1624,1626
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1628a1651
				>                         name: "pastrychef"
				1633d1655
				<                         name: "pastrychef"
				1653a1676
				> #Component: "kitchen"
				1698a1722,1724
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1702a1729
				>                         name:  "souschef"
				1706d1732
				<                         name: "souschef"
				1726a1753
				> #Component: "kitchen"
				1732a1760
				> #Component: "mon"
				1826a1855
				> #Component: "mon"
				1952a1982
				> #Component: "mon"
				1989a2020
				> #Component: "mon"
				2156a2188
				> #Component: "mon"
				2402a2435
				> #Component: "proxy"
				2478a2512
				> #Component: "proxy"
				2621a2656
				> #Component: "proxy"
				2714a2750
				> #Component: "proxy"

				"""
			ComparisonOutput: """
				2a3
				> #Component: string
				8a10
				> #Component: "frontend"
				49,52d50
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				57a56,59
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				61a64
				>                         name:  "bartender"
				65d67
				<                         name: "bartender"
				78a81
				> #Component: "frontend"
				119,122d121
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				127a127,130
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				131a135
				>                         name:  "breaddispatcher"
				135d138
				<                         name: "breaddispatcher"
				148a152
				> #Component: "frontend"
				189,192d192
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				197a198,201
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				201a206
				>                         name:  "host"
				205d209
				<                         name: "host"
				218a223
				> #Component: "frontend"
				259,262d263
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				267a269,272
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				271a277
				>                         name:  "maitred"
				275d280
				<                         name: "maitred"
				288a294
				> #Component: "frontend"
				329,332d334
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "8080"
				<                     }
				337a340,343
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "8080"
				>                     }
				358a365
				> #Component: "frontend"
				399,402d405
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				407a411,414
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				427a435
				> #Component: "frontend"
				468,471d475
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                         "prometheus.io.port":   "7080"
				<                     }
				476a481,484
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                         "prometheus.io.port":   "7080"
				>                     }
				480a489
				>                         name:  "waterdispatcher"
				484d492
				<                         name: "waterdispatcher"
				497a506
				> #Component: "frontend"
				503a513
				> #Component: "infra"
				568a579
				> #Component: "infra"
				606a618
				> #Component: "infra"
				809a822
				> #Component: "infra"
				892a906
				> #Component: "infra"
				968a983
				> #Component: "infra"
				1047a1063
				> #Component: "infra"
				1053a1070
				> #Component: "kitchen"
				1094,1096d1110
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1101a1116,1118
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1134a1152
				>                         name: "caller"
				1139d1156
				<                         name: "caller"
				1159a1177
				> #Component: "kitchen"
				1200,1202d1217
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1207a1223,1225
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1240a1259
				>                         name: "dishwasher"
				1245d1263
				<                         name: "dishwasher"
				1265a1284
				> #Component: "kitchen"
				1306,1308d1324
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1313a1330,1332
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1329a1349,1352
				>                         name:  "expiditer"
				>                         ports: [{
				>                             containerPort: 8080
				>                         }]
				1338,1340d1360
				<                         ports: [{
				<                             containerPort: 8080
				<                         }]
				1342d1361
				<                         name: "expiditer"
				1362a1382
				> #Component: "kitchen"
				1403,1405d1422
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1410a1428,1430
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1434a1455
				>                         name: "headchef"
				1439d1459
				<                         name: "headchef"
				1459a1480
				> #Component: "kitchen"
				1500,1502d1520
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1507a1526,1528
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1531a1553
				>                         name: "linecook"
				1536d1557
				<                         name: "linecook"
				1556a1578
				> #Component: "kitchen"
				1597,1599d1618
				<                     annotations: {
				<                         "prometheus.io.scrape": "true"
				<                     }
				1604a1624,1626
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1628a1651
				>                         name: "pastrychef"
				1633d1655
				<                         name: "pastrychef"
				1653a1676
				> #Component: "kitchen"
				1698a1722,1724
				>                     annotations: {
				>                         "prometheus.io.scrape": "true"
				>                     }
				1702a1729
				>                         name:  "souschef"
				1706d1732
				<                         name: "souschef"
				1726a1753
				> #Component: "kitchen"
				1732a1760
				> #Component: "mon"
				1826a1855
				> #Component: "mon"
				1952a1982
				> #Component: "mon"
				1989a2020
				> #Component: "mon"
				2156a2188
				> #Component: "mon"
				2402a2435
				> #Component: "proxy"
				2478a2512
				> #Component: "proxy"
				2621a2656
				> #Component: "proxy"
				2714a2750
				> #Component: "proxy"

				"""
		}, {
			Negated:          false
			CmdStr:           "cp snapshot2 snapshot"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "find . | grep kube.cue | xargs wc | tail -1"
			ExitCode: 0
			Output: """
				  935  1966 18279 total

				"""
			ComparisonOutput: """
				  935  1966 18279 total

				"""
		}]
	}
	prep_kube_tool: {
		StepType: 2
		Name:     "prep_kube_tool"
		Order:    36
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package kube

			objects: [ for v in objectSets for x in v {x}]

			objectSets: [
			\tservice,
			\tdeployment,
			\tstatefulSet,
			\tdaemonSet,
			\tconfigMap,
			]
			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/kube_tool.cue"
	}
	prep_ls_tool: {
		StepType: 2
		Name:     "prep_ls_tool"
		Order:    37
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package kube

			import (
			\t"text/tabwriter"
			\t"tool/cli"
			\t"tool/file"
			)

			command: ls: {
			\ttask: print: cli.Print & {
			\t\ttext: tabwriter.Write([
			\t\t\tfor x in objects {
			\t\t\t\t"\\(x.kind)  \\t\\(x.metadata.labels.component)  \\t\\(x.metadata.name)"
			\t\t\t},
			\t\t])
			\t}

			\ttask: write: file.Create & {
			\t\tfilename: "foo.txt"
			\t\tcontents: task.print.text
			\t}
			}
			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/ls_tool.cue"
	}
	initial_ls: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "initial_ls"
		Order:           38
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue cmd ls ./frontend/maitred"
			ExitCode: 0
			Output: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
			ComparisonOutput: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
		}]
	}
	shortform_ls: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "shortform_ls"
		Order:           39
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue ls ./frontend/maitred"
			ExitCode: 0
			Output: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
			ComparisonOutput: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
		}]
	}
	ls_all: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "ls_all"
		Order:           40
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue ls ./frontend/maitred"
			ExitCode: 0
			Output: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
			ComparisonOutput: """
				Service      frontend   maitred
				Deployment   frontend   maitred


				"""
		}]
	}
	prep_dump_tool: {
		StepType: 2
		Name:     "prep_dump_tool"
		Order:    41
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package kube

			import (
			\t"encoding/yaml"
			\t"tool/cli"
			)

			command: dump: {
			\ttask: print: cli.Print & {
			\t\ttext: yaml.MarshalStream(objects)
			\t}
			}
			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/dump_tool.cue"
	}
	prep_create_tool: {
		StepType: 2
		Name:     "prep_create_tool"
		Order:    42
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package kube

			import (
			\t"encoding/yaml"
			\t"tool/exec"
			\t"tool/cli"
			)

			command: create: {
			\ttask: kube: exec.Run & {
			\t\tcmd:    "kubectl create --dry-run=client -f -"
			\t\tstdin:  yaml.MarshalStream(objects)
			\t\tstdout: string
			\t}

			\ttask: display: cli.Print & {
			\t\ttext: task.kube.stdout
			\t}
			}
			"""
		Target: "/home/gopher/cue/doc/tutorial/kubernetes/tmp/services/create_tool.cue"
	}
	create_frontend: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "create_frontend"
		Order:           43
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cue create ./frontend/..."
			ExitCode: 0
			Output: """
				service/bartender created (dry run)
				service/breaddispatcher created (dry run)
				service/host created (dry run)
				service/maitred created (dry run)
				service/valeter created (dry run)
				service/waiter created (dry run)
				service/waterdispatcher created (dry run)
				deployment.apps/bartender created (dry run)
				deployment.apps/breaddispatcher created (dry run)
				deployment.apps/host created (dry run)
				deployment.apps/maitred created (dry run)
				deployment.apps/valeter created (dry run)
				deployment.apps/waiter created (dry run)
				deployment.apps/waterdispatcher created (dry run)


				"""
			ComparisonOutput: """
				service/bartender created (dry run)
				service/breaddispatcher created (dry run)
				service/host created (dry run)
				service/maitred created (dry run)
				service/valeter created (dry run)
				service/waiter created (dry run)
				service/waterdispatcher created (dry run)
				deployment.apps/bartender created (dry run)
				deployment.apps/breaddispatcher created (dry run)
				deployment.apps/host created (dry run)
				deployment.apps/maitred created (dry run)
				deployment.apps/valeter created (dry run)
				deployment.apps/waiter created (dry run)
				deployment.apps/waterdispatcher created (dry run)


				"""
		}]
	}
	go_get_k8s: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_get_k8s"
		Order:           44
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get k8s.io/api/apps/v1"
			ExitCode: 0
			Output: """
				go get: upgraded github.com/google/go-cmp v0.4.0 => v0.5.2
				go get: upgraded github.com/kr/pretty v0.1.0 => v0.2.0
				go get: upgraded github.com/pkg/errors v0.8.1 => v0.9.1
				go get: upgraded github.com/spf13/pflag v1.0.3 => v1.0.5
				go get: upgraded github.com/stretchr/testify v1.2.2 => v1.6.1
				go get: upgraded golang.org/x/net v0.0.0-20200226121028-0de0cce0169b => v0.0.0-20210224082022-3d97a244fca7
				go get: upgraded golang.org/x/text v0.3.2 => v0.3.4
				go get: upgraded golang.org/x/tools v0.0.0-20200612220849-54c614fe050c => v0.0.0-20210106214847-113979e3529a
				go get: upgraded golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543 => v0.0.0-20200804184101-5ec99f83aff1
				go get: upgraded gopkg.in/yaml.v3 v3.0.0-20200121175148-a6ecf24a6d71 => v3.0.0-20200313102051-9f266ea9e77c
				go get: added k8s.io/api v0.21.1

				"""
			ComparisonOutput: """

				go get: added k8s.io/api v0.21.1
				go get: upgraded github.com/google/go-cmp v0.4.0 => v0.5.2
				go get: upgraded github.com/kr/pretty v0.1.0 => v0.2.0
				go get: upgraded github.com/pkg/errors v0.8.1 => v0.9.1
				go get: upgraded github.com/spf13/pflag v1.0.3 => v1.0.5
				go get: upgraded github.com/stretchr/testify v1.2.2 => v1.6.1
				go get: upgraded golang.org/x/net v0.0.0-20200226121028-0de0cce0169b => v0.0.0-20210224082022-3d97a244fca7
				go get: upgraded golang.org/x/text v0.3.2 => v0.3.4
				go get: upgraded golang.org/x/tools v0.0.0-20200612220849-54c614fe050c => v0.0.0-20210106214847-113979e3529a
				go get: upgraded golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543 => v0.0.0-20200804184101-5ec99f83aff1
				go get: upgraded gopkg.in/yaml.v3 v3.0.0-20200121175148-a6ecf24a6d71 => v3.0.0-20200313102051-9f266ea9e77c
				"""
		}]
	}
}
Hash: "611102ce3f7fb24b4319c717d3d0dc3d5fed961771d14213275846229344b17e"
Delims: ["{{{", "}}}"]
