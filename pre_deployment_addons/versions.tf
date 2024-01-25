terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.9.0, < 6.0.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.3"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }

  }
}