resource "random_string" "eng_iam_rds_master_username_prefix" {
  length    = 2
  min_lower = 1
  min_upper = 1
  numeric   = false
  special   = false
}
resource "random_string" "eng_iam_rds_master_username_suffix" {
  length      = 14
  min_lower   = 4
  min_upper   = 6
  min_numeric = 4
  special     = false
}

resource "kubectl_manifest" "engiam_aws_rds_instance" {
  provider = kubectl

  sensitive_fields = [
    "spec.forProvider.caCertIdentifier",
    "spec.forProvider.dbSubnetGroupName",
    "spec.forProvider.username",
    "spec.forProvider.kmsKeyId",
    "spec.forProvider.vpcSecurityGroupIds"
  ]

  yaml_body = <<-YAML
  apiVersion: rds.aws.upbound.io/v1beta1
  kind: Instance
  metadata:
    name: ${local.namespace}-rds
  spec:
    forProvider:
      allocatedStorage: ${local.allocatedStorage}
      allowMajorVersionUpgrade: ${local.allowMajorVersionUpgrade}
      applyImmediately: ${local.applyImmediately}
      autoGeneratePassword: ${local.autoGeneratePassword}
      autoMinorVersionUpgrade: ${local.autoMinorVersionUpgrade}
      backupRetentionPeriod: ${local.backupRetentionPeriod}
      caCertIdentifier: ${local.rds_ca_certificate_identifier}
      copyTagsToSnapshot: ${local.copyTagsToSnapshot}
      dbSubnetGroupName: ${local.db_subnet_group_name}
      enabledCloudwatchLogsExports:
        - postgresql
        - upgrade
      engine: ${local.engine}
      engineVersion: "${local.engineVersion}"
      iamDatabaseAuthenticationEnabled: false
      instanceClass: ${local.dbInstanceClass}
      kmsKeyId: ${local.kms_key_id}
      maxAllocatedStorage: ${local.maxAllocatedStorage}
      multiAz: ${local.multiAz}
      parameterGroupName: default.postgres${local.engineVersion}
      passwordSecretRef:
        key: password
        name: ${local.namespace}-rds-conn-string
        namespace: ${local.namespace}
      performanceInsightsEnabled: false
      port: ${local.port}
      publiclyAccessible: ${local.publiclyAccessible}
      region: ${local.region}
      skipFinalSnapshot: ${local.skipFinalSnapshot}
      storageEncrypted: ${local.storageEncrypted}
      storageType: ${local.storageType}
      tags:
        hsp-rds-sensitive: "${local.sensitive_data}"
      username: "${random_string.eng_iam_rds_master_username_prefix.id}${random_string.eng_iam_rds_master_username_suffix.id}"
      vpcSecurityGroupIds:
        - ${local.vpc_security_group_1}
        - ${local.vpc_security_group_2}
  YAML

  depends_on = [random_string.eng_iam_rds_master_username_prefix,
  random_string.eng_iam_rds_master_username_suffix]
}