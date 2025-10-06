# Optional: add Cognito user pool with enforced MFA for staff
module "cognito_auth" {
  source       = "../modules/cognito_auth"
  project_name = var.project_name
  environment  = var.environment
  mfa          = "ON"  # enforce MFA for staff
  groups       = ["nurse","admin"]
}
# Next step (not included): add an HTTP API JWT authorizer using this user pool.
