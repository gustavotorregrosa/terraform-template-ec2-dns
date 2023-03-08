
variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0557a15b87f6559cf" # AMI id for Ubuntu 20.04 LTS
}

variable "instance_type" {
  default = "t2.micro"
}

variable "name" {
  default = "Example-EC2-instance"
}

variable "disk_size" {
  default = 16
}

variable "key_name" {
  default = null
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

# aws_route53_record variables
variable dns_name {
  default = "nextjs.gustavotorregrosa.link"
}

variable type {
  default = "A"
}
