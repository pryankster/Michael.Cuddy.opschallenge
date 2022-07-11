# Digital Ocean cloud projects

There are two separate projects in this directory, each in its own 
subdirectory:
* `loadbalance`     
A quick chunk of terraform code and a helper module to create some compute
resources and assign a load balancer to them.  In it's example state, deploys
NGINX as a target for the load balancer.  No further application configuration
or distribution is done.   See (loadbalance/README.md) for more information.
* `k8s`    
Terraform code to create a Kubernetes cluster on Digitial Ocean cloud.  This
terraform also creates a KUBECONFIG file which can be used to configure
access to the terraform generated cloud.

## Helper Scripts

* `docean_token.sh`     
  A BASH script which can be sourced (`. docean_token.sh`) to setup Digital 
  Ocean access token.  This will need to be customized with a valid Digital 
  Ocean API access token.  

  See "Authorization" below.

  The `docean_token` script also assumes that the private key will be in a 
  file called `id_docean` in the same directory as the script.

* `set_kube_config.sh`    
  A BASH script which can be sourced (`. set_kube_config.sh`) to setup the 
  `KUBECONFIG` variable to point to the Kubernetes configuration generated
  by the terraform code in the 'k8s' directory

  The `set_kube_config.sh` script assumes that the KUBECONFIG file will
  be in the same directory as the script.

## Authorization

The Digital ocean terraform provider in the `k8s` and `loadbalance` directory
is configured via environment variables:

* `TF_VAR_do_token` 
  This should be the Digitial Ocean access token.  It can be generated from
  the Digitial Ocean console, here: https://cloud.digitalocean.com/account/api/tokens.
* `TF_VAR_do_private_key`    
  This should be set for provisioning the hosts in the `loadbalance` directory.
  It should be an absolute path to the private key file to use for Digitial
  Ocean hosts.  The public key part of this key should be uploaded via the 
  Digital Ocean console, here: https://cloud.digitalocean.com/account/security

