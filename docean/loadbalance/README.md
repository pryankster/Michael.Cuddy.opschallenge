# Digital Ocean Compute Cluster / Load Balancer

This directory has example terraform code to create a compute cluster
in Digital Ocean's cloud.  The main grunt work is done by the module
`docean_service_instance` which provides blue/green support and scaling
of the cluster.

## Files
* `docean_service_instance`   
A helper module which create the compute hosts and their load balancer.  
Configures the load balancer to point to a blue or green instance.
* `project.tf`   
Create project and DNS domain reference. 
* `provider.tf`   
Configuration Digitial Ocean provider.  Authorization is provided through
Terraform automatic environment variables `TF_VAR_do_token` and `TF_VAR_do_private_key`.  If they are not set in the environment, terraform will prompt for their values.
* `service.tf`    
Invokes the  `docean_service_instance` module to "do the dirty work" in
creating a service cluster with compute resources and a load balancer. 
