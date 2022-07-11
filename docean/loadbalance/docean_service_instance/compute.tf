
resource "digitalocean_droplet" "host" {
    for_each = local.host_map
    image = each.value.image
    name = each.key
    region = each.value.region
    size = each.value.size
    ssh_keys = each.value.ssh_keys

    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.private_key)
        timeout = "2m"
    }

    provisioner "remote-exec" {
        inline = each.value.remote_exec
    }
}

// DOcean is strange ... resources are assigned to projects AFTER creation?
resource "digitalocean_project_resources" "host" {
    project = var.project_id
    resources = [for h in digitalocean_droplet.host: h.urn]
}


