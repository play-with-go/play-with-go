package guide

import (

	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	working_dir: "/home/gopher/cue/doc/tutorial/kubernetes"
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: _#go116CUELatestImage
}

Steps: k3d_init: preguide.#Command & {
	InformationOnly: true
	Source: """
		k3d cluster delete hello
		k3d cluster create hello
		"""
}

Steps: cue_version: preguide.#Command & {
	Source: """
		cue version
		"""
}

Steps: clone_cue: preguide.#Command & {
	Source: """
		git clone -q https://cue.googlesource.com/cue
		cd cue
		git checkout -q f014c14c97b13a40f0c85e18843f71a6ce0c1d22
		cd \(Defs.working_dir)
		"""
}

Steps: original_tree: preguide.#Command & {
	Source: """
		tree ./original | head
		"""
}

Steps: cp_original: preguide.#Command & {
	Source: """
		cp -a original tmp
		cd tmp
		"""
}

Steps: cue_mod_init: preguide.#Command & {
	Source: """
		cue mod init
		"""
}

Steps: try_import_1: preguide.#Command & {
	Source: """
		cd services
		! cue import ./...
		"""
}

Steps: try_import_2: preguide.#Command & {
	Source: """
		! cue import ./... -p kube
		"""
}

Steps: import_success: preguide.#Command & {
	Source: """
		cue import ./... -p kube -l 'strings.ToCamel(kind)' -l metadata.name -f
		"""
}

Steps: tree_head_post_import: preguide.#Command & {
	Source: """
		tree . | head
		"""
}

Steps: cat_configmap: preguide.#Command & {
	Source: """
		cat mon/prometheus/configmap.cue | head
		"""
}

Steps: import_recursive: preguide.#Command & {
	Source: """
		cue import ./... -p kube -l 'strings.ToCamel(kind)' -l metadata.name -f -R
		"""
}

Steps: cat_configmap_post_recursive_import: preguide.#Command & {
	Source: """
		cat mon/prometheus/configmap.cue | head
		"""
}

Steps: cue_eval_configmap_prometheus: preguide.#Command & {
	Source: """
		cue eval ./mon/prometheus -e configMap.prometheus
		"""
}

Steps: cue_eval_snapshot1: preguide.#Command & {
	Source: """
		cue eval -c ./... > snapshot
		"""
}

Steps: cp_breaddispatcher: preguide.#Command & {
	Source: """
		cp frontend/breaddispatcher/kube.cue .
		"""
}

Steps: upload_kube: preguide.#Upload & {
	Target: "\(Defs.working_dir)/tmp/services/kube.cue"
	Source: """
		package kube

		service: [ID=_]: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name: ID
				labels: {
					app:       ID     // by convention
					domain:    "prod" // always the same in the given files
					component: string // varies per directory
				}
			}
			spec: {
				// Any port has the following properties.
				ports: [...{
					port:     int
					protocol: *"TCP" | "UDP" // from the Kubernetes definition
					name:     string | *"client"
				}]
				selector: metadata.labels // we want those to be the same
			}
		}

		deployment: [ID=_]: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: name: ID
			spec: {
				// 1 is the default, but we allow any number
				replicas: *1 | int
				template: {
					metadata: labels: {
						app:       ID
						domain:    "prod"
						component: string
					}
					// we always have one namesake container
					spec: containers: [{name: ID}]
				}
			}
		}

		"""
}

Steps: cue_eval_snapshot_bad: preguide.#Command & {
	Source: """
		! cue eval -c ./... > snapshot2
		"""
}

Steps: add_field_previous_template_def: preguide.#Upload & {
	Target:   "\(Defs.working_dir)/tmp/services/kube.cue"
	Renderer: preguide.#RenderDiff & {Pre: Steps.upload_kube.Source}
	Source: """
		package kube

		service: [ID=_]: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name: ID
				labels: {
					app:       ID         // by convention
					domain:    "prod"     // always the same in the given files
					component: #Component // varies per directory
				}
			}
			spec: {
				// Any port has the following properties.
				ports: [...{
					port:     int
					protocol: *"TCP" | "UDP" // from the Kubernetes definition
					name:     string | *"client"
				}]
				selector: metadata.labels // we want those to be the same
			}
		}

		deployment: [ID=_]: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: name: ID
			spec: {
				// 1 is the default, but we allow any number
				replicas: *1 | int
				template: {
					metadata: labels: {
						app:       ID
						domain:    "prod"
						component: #Component
					}
					// we always have one namesake container
					spec: containers: [{name: ID}]
				}
			}
		}

		#Component: string

		"""
}

Steps: add_file_component_label_each_dir: preguide.#Command & {
	Source: """
		ls -d */ | sed 's/.$//' | xargs -I DIR sh -c 'cd DIR; echo "package kube

		#Component: \\"DIR\\"
		" > kube.cue; cd ..'
		"""
}

Steps: format_the_files: preguide.#Command & {
	Source: """
		cue fmt kube.cue */kube.cue
		"""
}

Steps: cue_eval_snapshot2: preguide.#Command & {
	Source: """
		cue eval -c ./... > snapshot2
		! diff -wu snapshot snapshot2
		"""
}

Steps: cp_snapshot1_snapshot2: preguide.#Command & {
	Source: """
		cp snapshot2 snapshot
		"""
}

Steps: cue_trim_remove_boilerplate: preguide.#Command & {
	Source: """
		find . | grep kube.cue | xargs wc | tail -1
		cue trim ./...
		find . | grep kube.cue | xargs wc | tail -1
		"""
}

// TODO: This actually shows a diff where it didn't before
Steps: cue_eval_check: preguide.#Command & {
	Source: """
		cue eval -c ./... > snapshot2
		! diff snapshot snapshot2
		"""
}

Steps: daemon_stateful_template: preguide.#Upload & {
	Target:   "\(Defs.working_dir)/tmp/services/kube.cue"
	Renderer: preguide.#RenderDiff & {Pre: Steps.add_field_previous_template_def.Source}
	Source: """
		package kube

		service: [ID=_]: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name: ID
				labels: {
					app:       ID         // by convention
					domain:    "prod"     // always the same in the given files
					component: #Component // varies per directory
				}
			}
			spec: {
				// Any port has the following properties.
				ports: [...{
					port:     int
					protocol: *"TCP" | "UDP" // from the Kubernetes definition
					name:     string | *"client"
				}]
				selector: metadata.labels // we want those to be the same
			}
		}

		deployment: [ID=_]: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: name: ID
			spec: {
				// 1 is the default, but we allow any number
				replicas: *1 | int
				template: {
					metadata: labels: {
						app:       ID
						domain:    "prod"
						component: #Component
					}
					// we always have one namesake container
					spec: containers: [{name: ID}]
				}
			}
		}

		#Component: string

		daemonSet: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "DaemonSet"
			_name:      ID
		}

		statefulSet: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "StatefulSet"
			_name:      ID
		}

		deployment: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			_name:      ID
			spec: replicas: *1 | int
		}

		configMap: [ID=_]: {
			metadata: name: ID
			metadata: labels: component: #Component
		}

		_spec: {
			_name: string

			metadata: name: _name
			metadata: labels: component: #Component
			spec: selector: {}
			spec: template: {
				metadata: labels: {
					app:       _name
					component: #Component
					domain:    "prod"
				}
				spec: containers: [{name: _name}]
			}
		}

		"""
}

Steps: service_template: preguide.#Upload & {
	Target:   "\(Defs.working_dir)/tmp/services/kube.cue"
	Renderer: preguide.#RenderDiff & {Pre: Steps.daemon_stateful_template.Source}
	Source: #"""
		package kube

		service: [ID=_]: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name: ID
				labels: {
					app:       ID         // by convention
					domain:    "prod"     // always the same in the given files
					component: #Component // varies per directory
				}
			}
			spec: {
				// Any port has the following properties.
				ports: [...{
					port:     int
					protocol: *"TCP" | "UDP" // from the Kubernetes definition
					name:     string | *"client"
				}]
				selector: metadata.labels // we want those to be the same
			}
		}

		deployment: [ID=_]: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: name: ID
			spec: {
				// 1 is the default, but we allow any number
				replicas: *1 | int
				template: {
					metadata: labels: {
						app:       ID
						domain:    "prod"
						component: #Component
					}
					// we always have one namesake container
					spec: containers: [{name: ID}]
				}
			}
		}

		#Component: string

		daemonSet: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "DaemonSet"
			_name:      ID
		}

		statefulSet: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "StatefulSet"
			_name:      ID
		}

		deployment: [ID=_]: _spec & {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			_name:      ID
			spec: replicas: *1 | int
		}

		configMap: [ID=_]: {
			metadata: name: ID
			metadata: labels: component: #Component
		}

		_spec: {
			_name: string

			metadata: name: _name
			metadata: labels: component: #Component
			spec: selector: {}
			spec: template: {
				metadata: labels: {
					app:       _name
					component: #Component
					domain:    "prod"
				}
				spec: containers: [{name: _name}]
			}
		}

		// Define the _export option and set the default to true
		// for all ports defined in all containers.
		_spec: spec: template: spec: containers: [...{
			ports: [...{
				_export: *true | false // include the port in the service
			}]
		}]

		for x in [deployment, daemonSet, statefulSet] for k, v in x {
			service: "\(k)": {
				spec: selector: v.spec.template.metadata.labels

				spec: ports: [
					for c in v.spec.template.spec.containers
					for p in c.ports
					if p._export {
						let Port = p.containerPort // Port is an alias
						port:       *Port | int
						targetPort: *Port | int
					},
				]
			}
		}

		"""#
}

Steps: fix_infra_kubes: preguide.#Command & {
	Source: """
		cat <<EOF >> infra/events/kube.cue

		deployment: events: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
		EOF

		cat <<EOF >> infra/tasks/kube.cue

		deployment: tasks: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
		EOF

		cat <<EOF >> infra/watcher/kube.cue

		deployment: watcher: spec: template: spec: containers: [{ ports: [{_export: false}, _] }]
		EOF
		"""
}

// TODO: these numbers are also off... but ok?
Steps: trim_post_infra_fixup: preguide.#Command & {
	Source: """
		cue trim ./...
		find . | grep kube.cue | xargs wc | tail -1
		"""
}

// TODO: are the numbers right here? They are referenced in the markdown so check
// the diff with respect to the previous step
Steps: trim_simplify: preguide.#Command & {
	Source: """
		head frontend/breaddispatcher/kube.cue
		cue trim ./... -s
		head -7 frontend/breaddispatcher/kube.cue
		find . | grep kube.cue | xargs wc | tail -1
		"""
}

Steps: simplify_frontend: preguide.#Command & {
	Source: #"""
		cat <<EOF >> frontend/kube.cue

		deployment: [string]: spec: template: {
			metadata: annotations: {
				"prometheus.io.scrape": "true"
				"prometheus.io.port":   "\(spec.containers[0].ports[0].containerPort)"
			}
			spec: containers: [{
				ports: [{containerPort: *7080 | int}] // 7080 is the default
			}]
		}
		EOF
		cue fmt ./frontend
		"""#
}

// TODO: this looks like a big bad diff
Steps: check_diffs_post_frontend_simplify: preguide.#Command & {
	Source: """
		cue eval -c ./... > snapshot2
		! diff -wu snapshot snapshot2
		cp snapshot2 snapshot
		"""
}

// TODO: these numbers all look off
Steps: cue_trim_simplify_frontend: preguide.#Command & {
	Source: """
		cue trim -s ./frontend/...
		find . | grep kube.cue | xargs wc | tail -1
		"""
}

Steps: simplify_kitchen: preguide.#Command & {
	Source: #"""
		cat <<EOF >> kitchen/kube.cue

		deployment: [string]: spec: template: {
			metadata: annotations: "prometheus.io.scrape": "true"
			spec: containers: [{
				ports: [{
					containerPort: 8080
				}]
				livenessProbe: {
					httpGet: {
						path: "/debug/health"
						port: 8080
					}
					initialDelaySeconds: 40
					periodSeconds:       3
				}
			}]
		}
		EOF
		cue fmt ./kitchen
		"""#
}

Steps: simplify_kitchen_part2: preguide.#Command & {
	Source: #"""
		cat <<EOF >> kitchen/kube.cue

		deployment: [ID=_]: spec: template: spec: {
			_hasDisks: *true | bool

			// field comprehension using just "if"
			if _hasDisks {
				volumes: [{
					name: *"\(ID)-disk" | string
					gcePersistentDisk: pdName: *"\(ID)-disk" | string
					gcePersistentDisk: fsType: "ext4"
				}, {
					name: *"secret-\(ID)" | string
					secret: secretName: *"\(ID)-secrets" | string
				}, ...]

				containers: [{
					volumeMounts: [{
						name:      *"\(ID)-disk" | string
						mountPath: *"/logs" | string
					}, {
						mountPath: *"/etc/certs" | string
						name:      *"secret-\(ID)" | string
						readOnly:  true
					}, ...]
				}]
			}
		}
		EOF
		cue fmt ./kitchen
		cat <<EOF >> kitchen/souschef/kube.cue

		deployment: souschef: spec: template: spec: {
			 _hasDisks: false
		}

		EOF
		cue fmt ./kitchen/...
		"""#
}

// TODO: these numbers are off too
Steps: cue_trim_and_check_kitchen: preguide.#Command & {
	Source: #"""
		cue trim -s ./kitchen/...
		cue eval ./... > snapshot2
		! diff snapshot snapshot2
		cp snapshot2 snapshot
		find . | grep kube.cue | xargs wc | tail -1
		"""#
}

Steps: prep_kube_tool: preguide.#Upload & {
	Target: "\(Defs.working_dir)/tmp/services/kube_tool.cue"
	Source: #"""
		package kube

		objects: [ for v in objectSets for x in v {x}]

		objectSets: [
			service,
			deployment,
			statefulSet,
			daemonSet,
			configMap,
		]
		"""#
}

Steps: prep_ls_tool: preguide.#Upload & {
	Target: "\(Defs.working_dir)/tmp/services/ls_tool.cue"
	Source: #"""
		package kube

		import (
			"text/tabwriter"
			"tool/cli"
			"tool/file"
		)

		command: ls: {
			task: print: cli.Print & {
				text: tabwriter.Write([
					for x in objects {
						"\(x.kind)  \t\(x.metadata.labels.component)  \t\(x.metadata.name)"
					},
				])
			}

			task: write: file.Create & {
				filename: "foo.txt"
				contents: task.print.text
			}
		}
		"""#
}

Steps: initial_ls: preguide.#Command & {
	Source: #"""
		cue cmd ls ./frontend/maitred
		"""#
}

Steps: shortform_ls: preguide.#Command & {
	Source: #"""
		cue ls ./frontend/maitred
		"""#
}

Steps: ls_all: preguide.#Command & {
	Source: #"""
		cue ls ./frontend/maitred
		"""#
}

Steps: prep_dump_tool: preguide.#Upload & {
	Target: "\(Defs.working_dir)/tmp/services/dump_tool.cue"
	Source: #"""
		package kube

		import (
			"encoding/yaml"
			"tool/cli"
		)

		command: dump: {
			task: print: cli.Print & {
				text: yaml.MarshalStream(objects)
			}
		}
		"""#
}

Steps: prep_create_tool: preguide.#Upload & {
	Target: "\(Defs.working_dir)/tmp/services/create_tool.cue"
	Source: #"""
		package kube

		import (
			"encoding/yaml"
			"tool/exec"
			"tool/cli"
		)

		command: create: {
			task: kube: exec.Run & {
				cmd:    "kubectl create --dry-run=client -f -"
				stdin:  yaml.MarshalStream(objects)
				stdout: string
			}

			task: display: cli.Print & {
				text: task.kube.stdout
			}
		}
		"""#
}

Steps: create_frontend: preguide.#Command & {
	Source: #"""
		cue create ./frontend/...
		"""#
}

Steps: go_get_k8s: preguide.#Command & {
	Source: #"""
		go get k8s.io/api/apps/v1
		"""#
}
