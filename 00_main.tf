provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket               = "piwpiiwn-tfstate"
    workspace_key_prefix = "aws-k8s"
    key                  = "aws-k8s-tfstate.tfstate"
    region               = "eu-west-1"
    encrypt              = true
  }
}
