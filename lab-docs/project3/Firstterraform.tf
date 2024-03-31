provider "aws" {
region = "us-east-2"
}

resource "aws_instance" "demo-server" {
  ami = "ami-000c0df09737657b6"
  instance_type = "t2.micro"
  key_name = "project3-key"
}


