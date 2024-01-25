resource "kubectl_manifest" "engiam_service_account_role_namespace_resources" {
  provider = kubectl

  sensitive_fields = [
    "rules"
  ]

  yaml_body = <<-YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: Role
  metadata:
    name: eng-iam-hsdp:${local.namespace}:full-access-namespace-resources-role
    namespace: ${local.namespace}
  rules:
  - apiGroups:
    - '*'
    resources:
    - '*'
    verbs:
    - get
    - list
    - watch
    - create
    - update
    - patch
    - delete
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account_cluster_role_binding_crossplane_managed_resources
  ]
}

resource "kubectl_manifest" "engiam_service_account_role_binding_namespace_resources" {
  provider = kubectl

  sensitive_fields = [
    "roleRef.name",
    "subjects"
  ]

  yaml_body = <<-YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: eng-iam-hsdp:${local.namespace}:full-access-namespace-resources
    namespace: ${local.namespace}
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: Role
    name: eng-iam-hsdp:${local.namespace}:full-access-namespace-resources-role
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: eng-iam-hsdp:${local.namespace}:full-access-namespace-group
  - namespace: ${local.namespace}
    kind: ServiceAccount
    name: ${local.service_account}
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account_role_namespace_resources
  ]
}