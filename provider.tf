terraform {
  required_providers {
    nutanix = {
      source = "nutanix/nutanix"
      version = "1.2.1"
    }
  }
}

provider "nutanix" {
  username     = var.nutanix_user
  password     = var.nutanix_password
  endpoint     = var.nutanix_endpoint
  insecure     = true
  port         = 9440
  wait_timeout = 30
}