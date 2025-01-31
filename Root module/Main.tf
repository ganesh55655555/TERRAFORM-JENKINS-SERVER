provider "aws" {
  region = "eu-north-1"  # Update with your preferred region
}

module "ec2" {
  source        = "./modules/ec2"
  key_name      = var.key_name
  instance_type = var.instance_type
}

module "snapshot" {
  source        = "./modules/snapshot"
  volume_id     = aws_instance.jenkins.ebs_block_device[0].volume_id  
  snapshot_name = var.snapshot_name
}
