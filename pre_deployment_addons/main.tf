module "namespace" {
  source = "./modules/namespace"
  count  = var.enable_namespace_creation ? 1 : 0

  namespace = var.namespace
}

module "s3Bucket" {
  source = "./modules/s3bucket"
  count  = var.enable_bucket_creation ? 1 : 0

  namespace               = var.namespace
  region                  = var.region
  objects_expiration_days = var.objects_expiration_days
}

module "iam_resources" {
  source = "./modules/iam-resources"
  count  = var.enable_iam_resource_creation ? 1 : 0

  namespace            = var.namespace
  s3policyArn          = var.s3policyArn
  admin_user_policyArn = var.admin_user_policyArn

  depends_on = [module.s3Bucket]
}

module "rds_instances" {
  source = "./modules/rds"
  count  = var.enable_rds_creation ? 1 : 0

  region                        = var.region
  namespace                     = var.namespace
  rds_ca_certificate_identifier = var.rds_ca_certificate_identifier
  db_subnet_group_name          = data.aws_db_subnet_group.eng_iam_rds_subnet_group[0].name
  kms_key_id                    = data.aws_kms_key.eng_iam_rds_kms_key[0].arn
  vpc_security_group_1          = data.aws_security_groups.eng_iam_rds_default_vpc_security_group[0].ids[0]
  vpc_security_group_2          = data.aws_security_groups.eng_iam_rds_cluster_vpc_security_group[0].ids[0]
  allocatedStorage              = var.allocatedStorage
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
  skipFinalSnapshot             = var.skipFinalSnapshot
  storageEncrypted              = var.storageEncrypted
  storageType                   = var.storageType
  allowMajorVersionUpgrade      = var.allowMajorVersionUpgrade
}
