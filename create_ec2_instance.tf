provider "aws" {
  profile = "default"
  region  = "us-east-1"
  access_key = "access_key"
  secret_key = "secret_key"
}

resource "aws_security_group" "allow_tls" {
  name        = "allw http-https-ssh"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_key_pair" "my_blog_key" {
  key_name = "my_tf_key"
  public_key = file("~/.ssh/myblog-key.pub")
}



resource "aws_instance" "ec2_instance_from_tf" {
  ami = "ami-0c4f7023847b90238"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_blog_key.key_name
  security_groups = ["allw http-https-ssh"]

  tags = {
    Name = "ec2_instance_from_tf"
  }
}

