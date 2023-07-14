data "vault_generic_secret" "test_1" {
  path = "secret/${local.vault_path}"
}

resource "local_sensitive_file" "yaml_file" {
  filename = local.local_file_name
  content = replace(
    yamlencode(
      jsondecode(data.vault_generic_secret.test_1.data_json)
    ), "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:"
  )
  file_permission = "0644"

  depends_on = [
    data.vault_generic_secret.test_1
  ]
}