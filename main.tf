provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnet" "example" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name ="Subnet-B"
  }
}
resource "aws_security_group" "instance_sg" {
   name ="instance_sg"
   vpc_id = data.aws_vpc.default.id
   ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

   }
}
resource "aws_instance" "ec2-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = data.aws_subnet.example
    key_name = var.ssh_key_name
tags = {
    Name ="My First instance"
}
}