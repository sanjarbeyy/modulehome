terraform {
  cloud {
    organization = "sanjarbey"

    workspaces {
      name = "module-home"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "subnets" {
  type = map(object({
    cidr_block = string
  }))
  default = {}
  description = "variable for subnet"
}

variable "availability_zone" {
  type = string
  default = ""
  description = "var for availability zone"
}


variable "vpc_cidr" {
  type = string
  default = ""
  description = "var for vpccdir"
}

module "vpc" {
  source   = "./module/vpc/"
  vpc_cidr = "10.0.0.0/16" #var.vpc_cidr
}

module "subnets" {
  source = "./module/subnet/"
  vpc_id = module.vpc.vpc_id
  subnets = {
    my_test1_subnet_using_module = {
        cidr_block = "10.0.1.0/24"
        availability_zone = "us-east-1c"
    }
    my-test2-subnet = {
        cidr_block = "10.0.2.0/24"
        availability_zone = "us-east-1a"
    }
    my-test3-subnet = {
        cidr_block = "10.0.3.0/24"
        availability_zone = "us-east-1b"
    }
  }
}
