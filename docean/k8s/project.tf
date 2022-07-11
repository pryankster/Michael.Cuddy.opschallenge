
resource "digitalocean_project" "default" {
    name = var.project_name
    description = "SRA homework project kubernetes" 
    purpose = "Spin up k8s example cluster on Digitial Ocean cloud"
    environment = "Development"
}

// I've delegated 'sra.immobilehome.studio' to DOcean.
resource "digitalocean_domain" "default" {
    name = var.dns_subdomain
}

// handy-dandy shortcuts
locals {
    project_id = digitalocean_project.default.id
    dns_domain_id = digitalocean_domain.default.id
}

// DOcean is strange ... resources are assigned to projects AFTER creation?
resource "digitalocean_project_resources" "domain" {
    project = local.project_id
    resources = [ digitalocean_domain.default.urn ]
}
