terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.1"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = "us-east-1"
}

# AWS EC2 instance resource 
resource "aws_instance" "nextjsmachine" {
  ami           = var.ami_id # Ubuntu 20.04 LTS
  instance_type = var.instance_type # t2.micro instance type

  
  tags = {
    Name = var.name
  }

  # Instance can only be connected via ssh if public key is given.
  # In this case, we're not generating a public key.
  key_name               = var.key_name
  associate_public_ip_address = true

  # Create EBS volumes and attach it to the instance.
  ebs_block_device {
    volume_size = var.disk_size
    device_name = "/dev/sdf"
    #volume_type = "gp2"
  }

  # Allow HTTP and HTTPS traffic from anywhere.
  # Allow SSH traffic only from ip addresses in variable
  # security_groups  = [module.sg.this_security_group_id]

  
}

# aws_route53_record resource 
resource "aws_route53_record" "www" {
  name    = var.dns_name
  type    = var.type
  # zone_id = data.aws_route53_zone.primary.zone_id
  zone_id = "Z08661261H6MAGFOQPHG9"

  records = [aws_instance.nextjsmachine.public_ip]
  ttl     = "300"
}
