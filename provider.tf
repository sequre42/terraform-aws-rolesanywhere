provider "aws" {
  region = "us-east-1"
  profile = "sso-dg-sandbox-1"
}

terraform {
  required_version = "1.6.2" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.0"
    }
  }

    backend "local" {
    path = ".tfstate/terraform.tfstate"
  }

}