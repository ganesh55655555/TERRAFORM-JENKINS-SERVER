variable "volume_id" {
  description = "ID of the EBS volume to create a snapshot for"
  type        = string
}

variable "snapshot_name" {
  description = "Name of the snapshot schedule"
  type        = string
}


variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-north-1"
