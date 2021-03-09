resource "aws_security_group" "web-node" {
  name        = "web-node"
  description = "Web Security Group"
  vpc_id      = aws_vpc.coalfire-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "web-node"
  }
}

#ec2 instance. public. t2.micro. RHEL 8. Subnet 1
resource "aws_instance" "coalfire-rhel1" {
  ami             = "ami-079230242a8aa0973"
  instance_type   = "t2.micro"
  key_name        = "coalfire-key"
  subnet_id       = aws_subnet.sub1.id
  security_groups = [aws_security_group.web-node.id]

  tags = {
    Name = "coalfire-rhel-sub1"
  }
}

/*
resource "aws_instance" "test" {
  ami           = "ami-079230242a8aa0973"
  instance_type = "t2.micro"
  key_name      = "coalfire-key"
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo yum install httpd -y
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF

  tags = {
    Name = "test"
  }
}
*/

#ec2 instance. private. t2.micro. RHEL 8. Subnet 3. Apache installed
resource "aws_instance" "coalfire-rhel3" {
  ami               = "ami-079230242a8aa0973"
  instance_type     = "t2.micro"
  key_name          = "coalfire-key"
  source_dest_check = false
  subnet_id         = aws_subnet.sub3.id
  security_groups   = [aws_security_group.web-node.id]

  user_data = <<-EOF
                  #!/bin/bash
                  sudo yum install httpd -y
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  sudo su
                  echo "<p> Coalfire test </p>" >> /var/www/html/index.html
                  EOF

  tags = {
    Name = "coalfire-rhel-sub3"
  }
}
