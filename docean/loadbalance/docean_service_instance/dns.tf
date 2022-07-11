
// create DNS A records for each LB instance
// i.e. '{name}-{env}.{domain}
resource "digitalocean_record" "lb" {
    for_each = local.IC.instances
    domain = var.dns_domain_id

    type = "A"
    name = "${local.IC.name}-${each.key}"
    value = digitalocean_loadbalancer.lb[each.key].ip
}

// create CNAME for active instance
resource "digitalocean_record" "entry" {
    domain = var.dns_domain_id
    type = "CNAME"
    name = local.IC.name
    // must end with '.'
    value = "${digitalocean_record.lb[local.IC.active_instance].fqdn}."
    // one minute for 'hot-swap' DNS entry
    ttl = 60
}
