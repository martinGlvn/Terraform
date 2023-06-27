terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Region -> us-east-1
provider "aws" {
  region = "us-east-1"
}
# Services = EC2 -> t2.micro -> Ubuntu -> us-east-1
resource "aws_instance" "example" {
  ami           = "ami-011899242bb902164"
  instance_type = "t2.micro"
}