output "rds_subnet_group_name" {
  description = "DB subnet group name successfully fetched"
  value       = var.enable_rds_creation ? data.aws_db_subnet_group.eng_iam_rds_subnet_group[0] : null
  sensitive   = true
}

output "rds_kms_key" {
  description = "RDS KMS key successfully fetched"
  value       = var.enable_rds_creation ? data.aws_kms_key.eng_iam_rds_kms_key[0] : null
  sensitive   = true
}

output "rds_default_vpc_sg" {
  description = "Default VPC security group successfully fetched"
  value       = var.enable_rds_creation ? data.aws_security_groups.eng_iam_rds_default_vpc_security_group[0] : null
  sensitive   = true
}

output "rds_cluster_vpc_sg" {
  description = "Cluster VPC security group successfully fetched"
  value       = var.enable_rds_creation ? data.aws_security_groups.eng_iam_rds_cluster_vpc_security_group[0] : null
  sensitive   = true
}

output "namespace" {
  description = "New namespace created"
  value       = var.enable_namespace_creation ? module.namespace : null
  sensitive   = true
}

output "s3Bucket" {
  description = "New s3 bucket available in the cluster"
  value       = var.enable_bucket_creation ? module.s3Bucket : null
  sensitive   = true
}

output "iam_resources" {
  description = "AWS IAM resources (e.g, bucket, users) available in the cluster"
  value       = var.enable_iam_resource_creation ? module.iam_resources : null
  sensitive   = true
}

output "rds_instances" {
  description = "RDS instance/s available in the cluster"
  value       = var.enable_rds_creation ? module.rds_instances : null
  sensitive   = true
}