output "jenkins_url" {
  description = "Jenkins server public URL"
  value       = "http://${module.ec2.elastic_ip}"
}
