
resource "digitalocean_project" "default" {
    name = "sra_homework"
    description = "SRA homework project" 
    purpose = "Example stuff."
    environment = "Development"
}

resource "digitalocean_domain" "default" {
    name = "sra.immobilehome.studio"
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

