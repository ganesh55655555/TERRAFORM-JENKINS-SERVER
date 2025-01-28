provider "aws" {
  region = "eu-north-1" # Update with your preferred region
}


module "ec2" {
  source          = "./modules/ec2"
  key_name        = var.key_name
  instance_type   = var.instance_type
}

module "snapshot" {
  source        = "./modules/snapshot"
  volume_id     = "vol-05933014c0823c62e" # Replace with your volume ID
  snapshot_name = var.snapshot_name
}

