
data "aws_caller_identity" "current" {}
resource "aws_backup_vault" "main" {
  name = "${var.snapshot_name}-vault"
}

resource "aws_backup_plan" "daily" {
  name = var.snapshot_name

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 12 * * ? *)"  # Daily backup at 12:00 UTC
  }
}

resource "aws_backup_selection" "ebs" {
  name     = "daily-ebs-backup"
  iam_role_arn  = aws_iam_role.backup_role.arn
  plan_id  = aws_backup_plan.daily.id  

  resources = [
 "arn:aws:ec2:${var.region}:${data.aws_caller_identity.current.account_id}:volume/${var.volume_id}"
  ]
}


resource "aws_iam_role" "backup_role" {
  name = "backup-role"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_role.name
}

