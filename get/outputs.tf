output "vault_secret_retrieved" {
  description = "vault test secret retrieved"
  value       = jsondecode(data.vault_generic_secret.test_1.data_json)
  sensitive   = true
}

output "yaml_file_generated" {
  description = "yaml file generated successfully"
  value       = local_sensitive_file.yaml_file
  sensitive   = true
}