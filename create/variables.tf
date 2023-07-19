variable "vault_addr" {
  description = "Host address of the vault server"
  type        = string
  nullable    = false
}

variable "vault_token" {
  description = "Auth token to access vault server"
  type        = string
  nullable    = false
}

variable "vault_path" {
  description = "Vault path to store secrets"
  type        = string
  nullable    = false
}