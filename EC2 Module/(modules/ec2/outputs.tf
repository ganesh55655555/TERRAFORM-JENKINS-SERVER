output "elastic_ip" {
  description = "The Elastic IP associated with the EC2 instance"
  value       = aws_eip.jenkins_ip.public_ip
}

output "volume_id" {
  description = "The ID of the EBS volume attached to the EC2 instance"
  value       = aws_ebs_volume.jenkins_data.id
}

