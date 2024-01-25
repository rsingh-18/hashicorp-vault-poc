variable "namespace" {
  description = "namespace to be created"
  type        = string
  nullable    = false
}

variable "s3policyArn" {
  description = "ARN of policy to be attached to AWS IAM s3 user"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "admin_user_policyArn" {
  description = "ARN of policy to be attached to AWS IAM admin user"
  type        = string
  nullable    = false
  sensitive   = true
}