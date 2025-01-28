output "jenkins_url" {
  value = "http://${module.ec2.elastic_ip}"
  description = "Public URL for the Jenkins server"
}
output "jenkins_public_ip" {
  description = "Public Elastic IP of the Jenkins server"
  value       = module.ec2.elastic_ip
}
