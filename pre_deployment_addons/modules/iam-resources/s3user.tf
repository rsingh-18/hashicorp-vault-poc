resource "kubectl_manifest" "engiam_aws_s3_user" {
  provider = kubectl

  sensitive_fields = [
    "spec.forProvider.permissionsBoundary"
  ]

  yaml_body = <<-YAML
  apiVersion: iam.aws.upbound.io/v1beta1
  kind: User
  metadata:
    name: ${local.namespace}-s3-user
  spec:
    forProvider:
      permissionsBoundary: ${local.s3policyArn}
  YAML
}

resource "kubectl_manifest" "engiam_aws_s3_user_policy_attachment" {
  provider = kubectl

  sensitive_fields = [
    "spec.forProvider.policyArn"
  ]

  yaml_body = <<-YAML
  apiVersion: iam.aws.upbound.io/v1beta1
  kind: UserPolicyAttachment
  metadata:
    name: ${local.namespace}-s3-user-policy-attachment
  spec:
    forProvider:
      policyArn: ${local.s3policyArn}
      user: ${local.namespace}-s3-user
  YAML
}

resource "kubectl_manifest" "engiam_aws_s3_user_access_key" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: iam.aws.upbound.io/v1beta1
  kind: AccessKey
  metadata:
    name: ${local.namespace}-s3-user-access-key
  spec:
    forProvider:
      status: Active
      user: ${local.namespace}-s3-user
    writeConnectionSecretToRef:
      name: ${local.namespace}-s3-user-access-key
      namespace: ${local.namespace}
  YAML
}