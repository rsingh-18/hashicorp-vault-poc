provider "vault" {
  address            = local.vault_addr
  add_address_to_env = true
  token              = local.vault_token
}