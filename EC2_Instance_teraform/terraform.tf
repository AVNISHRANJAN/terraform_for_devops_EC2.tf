terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }

  backend "s3" {
    bucket       = "josh-batch10-remote-bucket-devops" #s3 bucket name
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
