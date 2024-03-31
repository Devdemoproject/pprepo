provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "demo-server" {
  ami           = "ami-000c0df09737657b6"
  instance_type = "t2.micro"
  key_name      = "project3-key"
  security_groups = [aws_security_group.demo-sg.name]
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "SSH Access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}






























