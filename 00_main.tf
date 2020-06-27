provider "aws" {
  region = var.region

  shared_credentials_file = "~/.aws/credentials"
  profile                 = "piwpiiwn"
}

terraform {
  backend "s3" {
    bucket               = "piwpiiwn-tfstate"
    dynamodb_table       = "terraform-lock"
    workspace_key_prefix = "aws-k8s"
    key                  = "aws-k8s-tfstate.tfstate"
    region               = "eu-west-1"
    encrypt              = true

    shared_credentials_file = "~/.aws/credentials"
    profile                 = "piwpiiwn"
  }
}
