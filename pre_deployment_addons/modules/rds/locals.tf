locals {
  allocatedStorage              = var.allocatedStorage
  allowMajorVersionUpgrade      = var.allowMajorVersionUpgrade
  applyImmediately              = var.applyImmediately
  autoGeneratePassword          = var.autoGeneratePassword
  autoMinorVersionUpgrade       = var.autoMinorVersionUpgrade
  maxAllocatedStorage           = var.maxAllocatedStorage
  backupRetentionPeriod         = var.backupRetentionPeriod
  copyTagsToSnapshot            = var.copyTagsToSnapshot
  multiAz                       = var.multiAz
  dbInstanceClass               = var.dbInstanceClass
  engine                        = var.engine
  engineVersion                 = var.engineVersion
  port                          = var.port
  publiclyAccessible            = var.publiclyAccessible
  rds_ca_certificate_identifier = var.rds_ca_certificate_identifier
  skipFinalSnapshot             = var.skipFinalSnapshot
  storageEncrypted              = var.storageEncrypted
  storageType                   = var.storageType
  db_subnet_group_name          = var.db_subnet_group_name
  region                        = var.region
  namespace                     = var.namespace
  kms_key_id                    = var.kms_key_id
  vpc_security_group_1          = var.vpc_security_group_1
  vpc_security_group_2          = var.vpc_security_group_2
  sensitive_data                = "yes"
}