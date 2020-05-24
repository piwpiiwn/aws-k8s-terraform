provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket  = "aws-k8s-tfstate"
    key     = "aws-k8s-tfstate.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
