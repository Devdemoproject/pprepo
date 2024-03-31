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
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    name = "demo-vpc"
  }
  
}

resource "aws_subnet" "demo-vpc_public_subnet-01" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags ={
    name = "demo-vpc_public_subnet-01"
  }
  
}

resource "aws_subnet" "demo-vpc_public_subnet-02" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags ={
    name = "demo-vpc_public_subnet-02"
  }
  
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    name ="demo-igw"
  } 
}

resource "aws_route_table" "demo-public-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  
}

resource "aws_route_table_association" "demo-vpc_public_subnet-01" {
  subnet_id = 
}