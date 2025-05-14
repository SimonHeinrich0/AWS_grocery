provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "grocery_sg" {
  name        = "grocerymate-sg"
  description = "Allow HTTP, SSH, and port 5000"
  vpc_id      = "vpc-07f53ab21506dcb63"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "grocerymate-sg"
  }
}

resource "aws_instance" "grocerymate" {
  ami          		 = "ami-09eb4311cbaecf89d"
  instance_type          = "t3.micro"
  key_name 		 = "your_key_name"
  vpc_security_group_ids = [aws_security_group.grocery_sg.id]

  tags = {
    Name = "grocerymate-ec2"
  }
}
