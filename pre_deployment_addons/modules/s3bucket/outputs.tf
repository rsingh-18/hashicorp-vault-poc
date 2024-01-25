output "engiam_aws_s3_bucket" {
  description = "aws s3 bucket created"
  value       = kubectl_manifest.engiam_aws_s3_bucket
  sensitive   = true
}

output "engiam_aws_s3_bucket_lifecycle_configuration" {
  description = "aws s3 bucket lifecycle configuration created"
  value       = kubectl_manifest.engiam_aws_s3_bucket_lifecycle_configuration
}

output "engiam_aws_s3_bucket_public_access_block" {
  description = "aws s3 bucket public access block created"
  value       = kubectl_manifest.engiam_aws_s3_bucket_public_access_block
}

output "engiam_aws_s3_bucket_policy" {
  description = "aws s3 bucket policy added"
  value       = kubectl_manifest.engiam_aws_s3_bucket_policy
}