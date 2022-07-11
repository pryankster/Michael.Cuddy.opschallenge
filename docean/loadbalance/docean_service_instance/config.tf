
variable "project_id" {
    description = "digital ocean project ID to attach resources"
}

variable "dns_domain_id" {
    description = "digital ocean domain object ID for DNS resources"
}

variable "instance_config" {
    description = "map of instance configuration."
}

variable "private_key" {
    description = "name of file with digital ocean private key for SSH provisioning"
    type = string
}

locals {
    // this is the deafult instance configuration.
    default_config = {
        //
        // required config variables
        // (parameters listed here have no defaults, and TF will error if
        // they are not passed to the module
        //

        // name =  name of service

        //
        // service instances:
        //
        active_instance = "blue"
        instances = {
            blue = 2
            green = 2
        }

        //
        // compute parameters
        //

        image = "ubuntu-20-04-x64"
        region = "sfo3"
        size = "s-1vcpu-1gb"

        //
        // load balancer parameters
        //

        entry_port = 80
        entry_protocol = "http"

        target_port = 80
        target_protocol = "http"

        healthcheck = {
            port = 22
            protocol = "tcp"
        }

        // compute provisioning
        remote_exec = null
    }

    // merge instance config with default configuration, filter out 
    // per-host overrides
    config = merge(local.default_config, var.instance_config)

    IC = { for k,v in local.config: k => v if k != "overrides" }

    // get (optional) overrides from incoming instance config.
    OV = try(var.instance_config.overrides, {} )

    // generate a map of hosts
    host_map = merge( [for instance,count in local.IC.instances:
     {for c in range(1, count+1):
      // resource name like "foo-blue-1"
      "${local.IC.name}-${instance}-${c}" => 
          // merge any overrides (in order of least specific to most specific)
          // {instance}     (i.e.: 'blue' instance overrides )
          // {c}            (i.e.: '0' always for '0'th host )
          // {instance}-{c} (i.e.: 'green-0' for 0'th host in green instance)
          merge( local.IC, try(local.OV[instance],{}), try(local.OV["${instance}.{$c}"],{}),
          {
              number = c
              instance = instance
          })
      }
    ] ... )

   // shortcut.
   instance_names = keys(local.IC.instances)
}
