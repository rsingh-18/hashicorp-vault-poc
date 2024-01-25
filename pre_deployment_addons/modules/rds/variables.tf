variable "region" {
  description = "AWS region"
  type        = string
  nullable    = false
}

variable "namespace" {
  description = "namespace to be created"
  type        = string
  nullable    = false
}

variable "rds_ca_certificate_identifier" {
  description = "RDS ca certificate identifier"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "RDS db subnet group name"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "kms_key_id" {
  description = "AWS KMS key id"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "vpc_security_group_1" {
  description = "AWS RDS default VPC security group"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "vpc_security_group_2" {
  description = "AWS eks cluster VPC security group"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "allocatedStorage" {
  description = "minimum allocated storage for RDS instance"
  type        = number
  nullable    = false
}

variable "applyImmediately" {
  description = "flag to determine if changes to be applied immediately"
  type        = bool
  nullable    = false
}

variable "autoGeneratePassword" {
  description = "flag to determine if to generate a random password for RDS user"
  type        = bool
  nullable    = false
}

variable "autoMinorVersionUpgrade" {
  description = "flag to determine if minor version upgrades to be applied immediately"
  type        = bool
  nullable    = false
}

variable "maxAllocatedStorage" {
  description = "maximum allocated storage for RDS instance"
  type        = number
  nullable    = false
}

variable "backupRetentionPeriod" {
  description = "Number of days beyond which backups would not be stored. When set to 0, automated backups are disabled."
  type        = number
  nullable    = false
}

variable "copyTagsToSnapshot" {
  description = "flag to determine if tags are to be applied to snapshots"
  type        = bool
  nullable    = false
}

variable "multiAz" {
  description = "flag to determine if RDS instance is multiAZ"
  type        = bool
  nullable    = false
}

variable "dbInstanceClass" {
  description = "Instance class type of the RDS instance"
  type        = string
  nullable    = false
}

variable "engine" {
  description = "engine name of the RDS instance"
  type        = string
  nullable    = false
}

variable "engineVersion" {
  description = "engine version of the RDS instance"
  type        = string
  nullable    = false
}

variable "publiclyAccessible" {
  description = "flag to determine if RDS instance is publicly accessible"
  type        = bool
  nullable    = false
}

variable "port" {
  description = "port number of the RDS instance"
  type        = number
  nullable    = false
}

variable "skipFinalSnapshot" {
  description = "flag to determine if final snapshot creation to be skipped before deletion"
  type        = bool
  nullable    = false
}

variable "storageEncrypted" {
  description = "flag to determine if RDS storage instance is encrypted or not"
  type        = bool
  nullable    = false
}

variable "storageType" {
  description = "storage class type of the RDS instance"
  type        = string
  nullable    = false
}

variable "allowMajorVersionUpgrade" {
  description = "flag to determine whether to allow major version upgrade"
  type        = bool
  nullable    = false
}