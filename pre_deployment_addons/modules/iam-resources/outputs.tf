output "engiam_aws_s3_user" {
  description = "AWS IAM user created to access s3 bucket"
  value       = kubectl_manifest.engiam_aws_s3_user
  sensitive   = true
}

output "engiam_aws_s3_user_policy_attachment" {
  description = "Policy attached to s3 user"
  value       = kubectl_manifest.engiam_aws_s3_user_policy_attachment
  sensitive   = true
}

output "engiam_aws_s3_user_access_key" {
  description = "Credentials generated for s3 user"
  value       = kubectl_manifest.engiam_aws_s3_user_access_key
  sensitive   = true
}

output "engiam_aws_admin_user" {
  description = "AWS IAM user created with admin rights"
  value       = kubectl_manifest.engiam_aws_admin_user
  sensitive   = true
}

output "engiam_aws_admin_user_policy_attachment" {
  description = "Policy attached to admin user"
  value       = kubectl_manifest.engiam_aws_admin_user_policy_attachment
  sensitive   = true
}

output "engiam_aws_admin_user_access_key" {
  description = "Credentials generated for admin user"
  value       = kubectl_manifest.engiam_aws_admin_user_access_key
  sensitive   = true
}