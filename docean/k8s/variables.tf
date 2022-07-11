// default configuration variables -- can be tweaked as needed 

variable "project_name" {
    description = "Name of Digital Ocean project."
    type = string
    default = "sra_homework_k8s"
}

variable "dns_subdomain" {
    description = "Name of DNS domain to assign to project. (default is subdomain of my personal domain)"
    type = string
    default = "sra.immobilehome.studio"
}

variable "k8s_name" {
    description = "Name of k8s cluster"
    type = string
    default = "sra-test"
}


variable "k8s_region" {
    description = "Location for k8s cluster.  Use 'doctl compute region list' for valid values"
    type = string
    default = "sfo3"
}

variable "k8s_version" {
    description = "Which version of k8s to use.  Use 'doctl k8s options versions' for valid values"
    type = string
    default = "1.22.11-do.0"
}

variable "k8s_node_count" {
    description = "Number of nodes for default k8s worker pool"  
    type = string 
    default = 2
}

variable "k8s_worker_size" {
    description = "Digital Ocean worker size slug.  use 'doctl k8s options sizes' for list of valid values."
    type = string 
    default = "s-1vcpu-2gb"
}

