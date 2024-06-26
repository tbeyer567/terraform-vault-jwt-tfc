resource "vault_policy" "tfc" {
  name   = "tfc"
  policy = file("files/tfc-policy.hcl")
}

resource "vault_jwt_auth_backend" "jwt" {
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "tfc" {
  backend           = vault_jwt_auth_backend.jwt.path
  role_type         = "jwt"
  role_name         = "tfc"
  token_policies    = ["tfc"]
  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.org_name}:project:${var.project_name}:workspace:${var.workspace_name}:run_phase:*"
  }
  user_claim = "terraform_full_workspace"
  token_ttl  = 1200
}