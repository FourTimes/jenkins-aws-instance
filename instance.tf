resource "aws_security_group" "project-iac-sg" {
  name = "IAC-Sec-Group"
  description = "IAC-Sec-Group"
  vpc_id = "vpc-0638c60c0efc48912"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "project-iac" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a3f2b582374a501d"
  associate_public_ip_address = true
  key_name      = "key"

  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]

  root_block_device {
    delete_on_termination = true
    iops        = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags {
    Name        = "SERVER01"
    Environment = "DEV"
    OS          = "UBUNTU"
    Managed     = "IAC"
  }

  depends_on = [ aws_security_group.project-iac-sg ]
}


output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}
