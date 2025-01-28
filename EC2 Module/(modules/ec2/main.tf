resource "aws_instance" "jenkins" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras enable docker
    sudo yum install docker git -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    git clone ${var.github_repo_url} /home/ec2-user/jenkins
    cd /home/ec2-user/jenkins
    sudo docker-compose up -d
  EOF
}

resource "aws_eip" "jenkins_ip" {
  instance = aws_instance.jenkins.id
  public_ip = var.elastic_ip
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
