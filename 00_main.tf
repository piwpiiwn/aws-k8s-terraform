provider "aws" {
  region  = "eu-west-1"
  profile = "piwpiiwn"
}

terraform {
  backend "s3" {
    bucket         = "piwpiiwn-tfstate"
    dynamodb_table = "terraform-lock"
    key            = "aws-k8s-tfstate.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    profile        = "piwpiiwn"
  }
}
