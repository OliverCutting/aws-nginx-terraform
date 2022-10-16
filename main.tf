provider "aws" {
 profile = "default"
 region  = "eu-west-2"
}

resource "aws_s3_bucket" "nginx-tf" {
 bucket = "nginx-tf"
 acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "prod_web" {
 name        = "prod_web"
 description = "allow standard http and https ports inbound everything outbound"

 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
ingress {
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "prod_web" {
   ami           = "ami-0d0d8f322fb45f1c1"
   instance_type = "t3.micro"

   vpc_security_group_ids = [
     aws_security_group.prod_web.id
   ]

   tags = {
   "Terraform" : "true"
 }
}