terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
    description = "Digital Ocean access token.  set 'TF_VAR_do_token'"
}

variable "do_private_key" {
    description = "Path to private key"
}

provider "digitalocean" {
    token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
    name = "terraform"
}
