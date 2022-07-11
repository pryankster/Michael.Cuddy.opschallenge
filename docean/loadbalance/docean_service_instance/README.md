# DOcean Service Instance

This module provides a helper to create a "service instance" consisting of
compute resources, a load balancer to tie them together, and DNS entries to
point to them.

This module uses what I call an 'instance configuration' pattern. The 
configuration variables are all passed in as a large (relatively untyped) map.

Each resource created can then cherry-pick the parameters that it needs.  

Doing the resource configuration as a map allows for quick and easy additions
of variables with default values without upsetting any other users of the 
module, and requiring that they update their invocation of the module.

This module also provides 'blue/green' switching of the load balancer
(The names 'blue' and 'green' are not hard coded, they could be, for example,
'A' and 'B', etc.).  DNS entries will be created for each instance,
and then a CNAME for an active entry point will be created. 

Each instance can have varying size as well.

## Files

compute.tf - create compute resources
config.tf - buildup configuration variables from incoming configuration merged with default configuration. Most of the "magic" happens here.
dns.tf - create dns records for service
loadbalancer.tf - create load balancer for service.
provider.tf - configure Digital Ocean provider
