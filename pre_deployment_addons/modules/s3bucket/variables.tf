variable "namespace" {
  description = "namespace to be created"
  type        = string
  nullable    = false
}

variable "region" {
  description = "AWS region"
  type        = string
  nullable    = false
}

variable "objects_expiration_days" {
  description = "number of days beyond which data in s3 bucket will not be retained"
  type        = number
  nullable    = false
}