# Enable a Cognito JWT authorizer and protected routes at /secure/v1/*

data "aws_region" "current" {}

locals {
  issuer = "https://cognito-idp.${data.aws_region.current.name}.amazonaws.com/${module.cognito_auth.user_pool_id}"
  audience = [module.cognito_auth.app_client_id]
}

resource "aws_apigatewayv2_authorizer" "jwt" {
  api_id           = module.api.api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "${var.project_name}-${var.environment}-jwt"
  jwt_configuration {
    audience = local.audience
    issuer   = local.issuer
  }
}

data "aws_lambda_function" "api" { function_name = module.api.lambda_function_name }

resource "aws_apigatewayv2_integration" "secure" {
  api_id                 = module.api.api_id
  integration_type       = "AWS_PROXY"
  integration_uri        = data.aws_lambda_function.api.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "occupancy_secure" {
  api_id             = module.api.api_id
  route_key          = "GET /secure/v1/occupancy"
  target             = "integrations/${aws_apigatewayv2_integration.secure.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt.id
  authorization_type = "JWT"
}
