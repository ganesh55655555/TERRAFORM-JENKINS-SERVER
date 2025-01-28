provider "aws" {
  region = "us-east-1" # Update with your preferred region
}

module "network" {
  source = "./modules/network"
}

module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.network.vpc_id
  public_subnet   = module.network.public_subnet_id
  key_name        = var.key_name
  instance_type   = var.instance_type
  elastic_ip      = var.elastic_ip
  github_repo_url = var.github_repo_url
}

module "snapshot" {
  source        = "./modules/snapshot"
  volume_id     = module.ec2.volume_id
  snapshot_name = var.snapshot_name
}
