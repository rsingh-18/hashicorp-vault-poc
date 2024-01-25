resource "kubectl_manifest" "engiam_aws_s3_bucket" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: s3.aws.upbound.io/v1beta1
  kind: Bucket
  metadata:
    name: ${local.namespace}-s3-bucket
  spec:
    forProvider:
      forceDestroy: true
      objectLockEnabled: false
      region: ${local.region}
      tags:
        hsp-s3-sensitive: "${local.sensitive_data}"
  YAML
}

resource "kubectl_manifest" "engiam_aws_s3_bucket_lifecycle_configuration" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: s3.aws.upbound.io/v1beta1
  kind: BucketLifecycleConfiguration
  metadata:
    name: ${local.namespace}-s3-bucket-lifecycle-configuration
  spec:
    forProvider:
      bucket: ${local.namespace}-s3-bucket
      region: ${local.region}
      rule:
        - expiration:
            - days: ${local.objects_expiration_days}
          id: delete_objects_older_than_${local.objects_expiration_days}_days
          status: Enabled
  YAML
}

resource "kubectl_manifest" "engiam_aws_s3_bucket_public_access_block" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: s3.aws.upbound.io/v1beta1
  kind: BucketPublicAccessBlock
  metadata:
    name: ${local.namespace}-s3-bucket-public-access-block
  spec:
    forProvider:
      blockPublicAcls: true
      blockPublicPolicy: true
      bucket: ${local.namespace}-s3-bucket
      ignorePublicAcls: true
      region: ${local.region}
      restrictPublicBuckets: true
  YAML
}

resource "kubectl_manifest" "engiam_aws_s3_bucket_policy" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: s3.aws.upbound.io/v1beta1
  kind: BucketPolicy
  metadata:
    name: ${local.namespace}-s3-bucket-policy
  spec:
    forProvider:
      bucket: ${local.namespace}-s3-bucket
      policy: |
        {
          "Version": "2012-10-17",
          "Statement": [
            {
                "Sid": "AllowSSLRequestsOnly",
                "Action": "s3:*",
                "Effect": "Deny",
                "Resource": [
                    "arn:aws:s3:::${local.namespace}-s3-bucket",
                    "arn:aws:s3:::${local.namespace}-s3-bucket/*"
                ],
                "Condition": {
                  "Bool": {
                      "aws:SecureTransport": "false"
                  }
                },
                "Principal": "*"
            }
          ]
        }
      region: ${local.region}
  YAML
}