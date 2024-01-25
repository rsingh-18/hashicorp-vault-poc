variable "profile" {
  description = "AWS profile"
  type        = string
  nullable    = false
}

variable "region" {
  description = "AWS region"
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  nullable    = false
}

variable "enable_namespace_creation" {
  description = "enable creation of namespace"
  type        = bool
  default     = false
}

variable "namespace" {
  description = "namespace to be created"
  type        = string
  nullable    = false
}

variable "enable_bucket_creation" {
  description = "enable creation of s3 bucket"
  type        = bool
  default     = true
}

variable "objects_expiration_days" {
  description = "number of days beyond which data in s3 bucket will not be retained"
  type        = number
  nullable    = false
  default     = 14
}

variable "enable_iam_resource_creation" {
  description = "enable creation of AWS IAM resources"
  type        = bool
  default     = true
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

variable "enable_rds_creation" {
  description = "enable creation of RDS instance"
  type        = bool
  default     = true
}

variable "rds_ca_certificate_identifier" {
  description = "RDS ca certificate identifier"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "allocatedStorage" {
  description = "minimum allocated storage for RDS instance"
  type        = number
  nullable    = false
  default     = 50
}

variable "applyImmediately" {
  description = "flag to determine if changes to be applied immediately"
  type        = bool
  nullable    = false
  default     = true
}

variable "autoGeneratePassword" {
  description = "flag to determine if to generate a random password for RDS user"
  type        = bool
  nullable    = false
  default     = true
}

variable "autoMinorVersionUpgrade" {
  description = "flag to determine if minor version upgrades to be applied immediately"
  type        = bool
  nullable    = false
  default     = true
}

variable "maxAllocatedStorage" {
  description = "maximum allocated storage for RDS instance"
  type        = number
  nullable    = false
  default     = 100
}

variable "backupRetentionPeriod" {
  description = "Number of days beyond which backups would not be stored. When set to 0, automated backups are disabled."
  type        = number
  nullable    = false
  default     = 0
}

variable "copyTagsToSnapshot" {
  description = "flag to determine if tags are to be applied to snapshots"
  type        = bool
  nullable    = false
  default     = true
}

variable "multiAz" {
  description = "flag to determine if RDS instance is multiAZ"
  type        = bool
  nullable    = false
  default     = false
}

variable "dbInstanceClass" {
  description = "Instance class type of the RDS instance"
  type        = string
  nullable    = false
  default     = "db.m5.large"
}

variable "engine" {
  description = "engine name of the RDS instance"
  type        = string
  nullable    = false
  default     = "postgres"
}

variable "engineVersion" {
  description = "engine version of the RDS instance"
  type        = string
  nullable    = false
  default     = "14"
}

variable "publiclyAccessible" {
  description = "flag to determine if RDS instance is publicly accessible"
  type        = bool
  nullable    = false
  default     = false
}

variable "port" {
  description = "port number of the RDS instance"
  type        = number
  nullable    = false
  default     = 5432
}

variable "skipFinalSnapshot" {
  description = "flag to determine if final snapshot creation to be skipped before deletion"
  type        = bool
  nullable    = false
  default     = true
}

variable "storageEncrypted" {
  description = "flag to determine if RDS storage instance is encrypted or not"
  type        = bool
  nullable    = false
  default     = true
}

variable "storageType" {
  description = "storage class type of the RDS instance"
  type        = string
  nullable    = false
  default     = "gp2"
}

variable "allowMajorVersionUpgrade" {
  description = "flag to determine whether to allow major version upgrade"
  type        = bool
  nullable    = false
  default     = false
}