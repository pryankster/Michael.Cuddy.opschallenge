
// create a blue-green load balancer.

locals {
   droplets_by_instance = {for instance in local.instance_names:
       instance => [for name,config in local.host_map: 
           name if config.instance == local.config.active_instance ]
   }
}

resource "digitalocean_loadbalancer" "lb" {
    for_each = local.droplets_by_instance
    name = "${local.config.name}-${each.key}-lb"
    region = local.config.region

    forwarding_rule {
        entry_port = local.config.entry_port
        entry_protocol = local.config.entry_protocol

        target_port = local.config.target_port
        target_protocol = local.config.target_protocol
    }

    healthcheck {
        port                     = try(local.config.healthcheck.port,22)
        protocol                 = try(local.config.healthcheck.protocol,"tcp")
        check_interval_seconds   = try(local.config.health.check_interval_seconds,10)
        healthy_threshold        = try(local.config.healthcheck.healthy_threshold,5)
        response_timeout_seconds = try(local.config.healthcheck.response_timeout_seconds,5)
        unhealthy_threshold      = try(local.config.healthcheck.unhealthy_threshold,3)
    }

    droplet_ids = [ for name in each.value: digitalocean_droplet.host[name].id ]
}

// DOcean is strange ... resources are assigned to projects AFTER creation?
resource "digitalocean_project_resources" "lb" {
    project = var.project_id
    resources = [for lb in digitalocean_loadbalancer.lb: lb.urn]
}


