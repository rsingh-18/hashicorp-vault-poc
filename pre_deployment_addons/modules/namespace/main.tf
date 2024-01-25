resource "kubectl_manifest" "engiam_namespace" {
  provider = kubectl

  yaml_body = <<-YAML
  apiVersion: v1
  kind: Namespace
  metadata:
    name: ${var.namespace}
    labels:
      kubernetes.io/metadata.name: ${var.namespace}
  YAML
}