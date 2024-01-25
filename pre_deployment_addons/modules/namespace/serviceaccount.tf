resource "kubectl_manifest" "engiam_service_account" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    name: ${local.service_account}
    namespace: ${local.namespace}
  YAML

  depends_on = [
    kubectl_manifest.engiam_namespace
  ]
}

resource "kubectl_manifest" "engiam_service_account_secret" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: v1
  kind: Secret
  metadata:
    name: ${local.service_account}-token
    namespace: ${local.namespace}
    annotations:
      kubernetes.io/service-account.name: ${local.service_account}
  type: kubernetes.io/service-account-token
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account
  ]
}