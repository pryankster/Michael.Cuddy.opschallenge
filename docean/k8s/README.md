# Terraform: Digital Ocean K8s cluster 

This directory creates a k8s cluster on Digital Ocean's servers.

## Files 

* `provider.tf`     
  Confiugures provider for Digital Ocean cloud.
* `variables.tf`    
  Configuration.  Allows changing k8s cluster name, version, Digial Ocean 
  region, etc.
* `project.tf`
  Creates project and DNS subdomain.  DNS domain 'sra.immobilehome.studio' 
  is delegated to DOcean's DNS servers.
* `k8s.tf`
  Creates Kubernetes cluster.

## Description

When applied, this terraform code will create a project and k8s cluster in 
Digial Ocean's cloud.   The k8s cluster will be associated with the project.
A DNS subdomain will also be created (though no further delgation 
configuration will be done for the DNS subdomain, that's left as an external
exercise)

The terraform script will also generate a `KUBECONFIG` file in the parent
directory.  Further operations on the k8s cluster with `kubctl` requires 
setting up the `KUBECONFIG` environment variable.  See (../README.md) for
more information.
