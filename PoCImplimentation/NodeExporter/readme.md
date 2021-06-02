### The yaml files in this directory contain manifest files for Node Exporter deployment on Kubernetes.

The node exporter helps us to get node-level metrics and it is deployed on all K8s nodes, a Daemonset. It unveil all node metrics on the endpoint /metrics and on port 9100. 

To learn about it visit the following:
- https://github.com/prometheus/node_exporter
- https://prometheus.io/docs/guides/node-exporter/