resource "vault_generic_secret" "test_1" {
  path = "secret/${local.vault_path}"

  data_json = <<EOT
  {
    "foo":   "bar",
    "pizza": "cheese",
    "name": "rohit"
  }
  EOT
}