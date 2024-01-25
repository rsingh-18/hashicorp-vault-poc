output "eng_iam_rds_master_username" {
  description = "RDS master username created"
  value       = "${random_string.eng_iam_rds_master_username_prefix.id}${random_string.eng_iam_rds_master_username_suffix.id}"
}

output "engiam_aws_rds_instance" {
  description = "RDS instance created"
  value       = kubectl_manifest.engiam_aws_rds_instance
  sensitive   = true
}