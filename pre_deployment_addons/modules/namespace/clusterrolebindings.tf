resource "kubectl_manifest" "engiam_service_account_cluster_role_binding_system_resources" {
  provider = kubectl

  sensitive_fields = [
    "roleRef.name",
    "subjects"
  ]

  yaml_body = <<-YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
    name: eng-iam-hsdp:${local.namespace}:read-access-system-resources
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: ${local.cluster_role_ref}
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: eng-iam-hsdp:${local.namespace}:read-access-cluster-group
  - namespace: ${local.namespace}
    kind: ServiceAccount
    name: ${local.service_account}
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account_secret
  ]
}

resource "kubectl_manifest" "engiam_service_account_cluster_role_binding_crossplane_resources" {
  provider = kubectl

  sensitive_fields = [
    "roleRef.name",
    "subjects"
  ]

  yaml_body = <<-YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
    name: eng-iam-hsdp:${local.namespace}:read-access-crossplane-resources
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: ${local.crossplane_role_ref}
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: eng-iam-hsdp:${local.namespace}:read-access-cluster-group
  - namespace: ${local.namespace}
    kind: ServiceAccount
    name: ${local.service_account}
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account_cluster_role_binding_system_resources
  ]
}

resource "kubectl_manifest" "engiam_service_account_cluster_role_binding_crossplane_managed_resources" {
  provider = kubectl

  sensitive_fields = [
    "roleRef.name",
    "subjects"
  ]

  yaml_body = <<-YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
    name: eng-iam-hsdp:${local.namespace}:read-access-crossplane-managed-resources
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: ${local.crossplane_managed_role_ref}
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: eng-iam-hsdp:${local.namespace}:read-access-cluster-group
  - namespace: ${local.namespace}
    kind: ServiceAccount
    name: ${local.service_account}
  YAML

  depends_on = [
    kubectl_manifest.engiam_service_account_cluster_role_binding_crossplane_resources
  ]
}

