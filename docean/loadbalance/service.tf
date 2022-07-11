
module "bg_droplet" {
    source = "./docean_service_instance"

    private_key = var.do_private_key
    project_id = local.project_id
    dns_domain_id = local.dns_domain_id

    instance_config = { 
        // name of our service
        name = "www"

        // which instance should be active
        active_instance = "green"

        // how many droplets per instance, what are the instances called
        // (could be 'prod' and 'staging', for example
        instance_count = { "blue" : 1, "green": 1 }

        ssh_keys = [ data.digitalocean_ssh_key.terraform.id ]
        remote_exec = [
            "export PATH=$PATH:/usr/bin",
            "sudo apt update",
            "sudo apt install -y nginx"
        ]
    }
}
