output "vault_secret_created" {
  description = "vault test secret created"
  value       = vault_generic_secret.test_1
  sensitive   = true
}