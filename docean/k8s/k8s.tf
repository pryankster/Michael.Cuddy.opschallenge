
resource "digitalocean_kubernetes_cluster" "k8s" {
    name = var.k8s_name
    region = var.k8s_region
    version = var.k8s_version 
    node_pool { 
        name = "${var.k8s_name}-worker-pool"
        size = "s-1vcpu-2gb"
        node_count = 2
    }
}

/*
// use this stanza to create k8s resources in tf. 
// commented out because we don't create any k8s resources with this script.
provider "kubernetes" {
    host  = resource.digitalocean_kubernetes_cluster.k8s.endpoint
    token = resource.digitalocean_kubernetes_cluster.k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
        resource.digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
    )
}
*/

// DOcean is strange ... resources are assigned to projects AFTER creation?
resource "digitalocean_project_resources" "k8s" {
    project = local.project_id
    resources = [ digitalocean_kubernetes_cluster.k8s.urn ]
}

// write out k8s configuration to parent directory
resource "local_file" "docean_k8s_config" {
   filename = "${path.root}/../docean-k8s-kubeconfig.yaml"
   file_permission = "0600"
   content = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
}
