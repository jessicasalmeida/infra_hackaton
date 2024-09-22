resource "aws_cognito_user_pool" "paciente_pool" {
  name = "paciente_pool"
}

resource "aws_cognito_user_pool_domain" "paciente_pool_domain" {
  domain          = "paciente_pool_domain"
  user_pool_id    = aws_cognito_user_pool.paciente_pool.id
}

resource "aws_cognito_user_pool_client" "paciente_pool_cliente" {
  name                     = "paciente_pool_cliente"
  user_pool_id             = aws_cognito_user_pool.paciente_pool.id
  generate_secret          = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows      = ["code", "implicit"]
  allowed_oauth_scopes     = ["openid", "email", "profile"]
  callback_urls            = ["https://example.com/callback"]
  logout_urls              = ["https://example.com/logout"]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows      =  ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_ADMIN_USER_PASSWORD_AUTH"]

}

resource "aws_cognito_user" "default_user" {
  user_pool_id = aws_cognito_user_pool.paciente_pool.id
  username     = "paciente"
  password = "Fase!324"
  attributes = {
    terraform      = true
    foo            = "paciente"
    email          = "jessicasalmeida@hotmail.com"
    email_verified = true
  }
}
