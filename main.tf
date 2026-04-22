# terraform backend info 
# - usually goes to a seperate terraform.tf file
# - keeping i here in main.tf as per trello instruction

terraform {
  backend "s3" {
    bucket  = "jay-metapod-tf-state"
    key     = "dev/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2"
}

# defined rquired_providers such as AWS
provider "aws" {
  region = "eu-west-2"
}

# Added this to find /tf-files in child module
module "eks_stack" {
  source = "./tf-files"

  cluster_name = "jay-metapod-eks-cluster"
}