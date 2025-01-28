# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the default public subnet within the default VPC
data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = ["vpc-09deb36788d017bad"] # Replace this with the specific VPC ID
  }

  filter {
    name   = "subnet-id"
    values = ["subnet-07a30e82dc2fb3892"] # Replace with the actual subnet name tag
  }
}

resource "aws_instance" "jenkins" {
  ami                    = "ami-03abbbfd184c5f585" # Amazon Linux 2 AMI
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras enable docker
    sudo yum install docker git -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
  EOF
}

resource "aws_eip" "jenkins_ip" {
  instance = aws_instance.jenkins.id
}

resource "aws_ebs_volume" "jenkins_data" {
  availability_zone = aws_instance.jenkins.availability_zone
  size              = 20
}

resource "aws_volume_attachment" "attach" {
  instance_id = aws_instance.jenkins.id
  volume_id   = aws_ebs_volume.jenkins_data.id
  device_name = "/dev/xvdb"
}
