resource "aws_cognito_user_pool" "medico_pool" {
  name = "medico_pool"
}

resource "aws_cognito_user_pool_domain" "medico_pool_domain" {
  domain          = "medico_pool_domain"
  user_pool_id    = aws_cognito_user_pool.medico_pool.id
}

resource "aws_cognito_user_pool_client" "medico_pool_cliente" {
  name                     = "medico_pool_cliente"
  user_pool_id             = aws_cognito_user_pool.medico_pool.id
  generate_secret          = false
  allowed_oauth_flows_user_pool_client = true
allowed_oauth_flows      = ["code", "implicit"]
  allowed_oauth_scopes     = ["openid", "email", "profile"]
  callback_urls            = ["https://example.com/callback"]
  logout_urls              = ["https://example.com/logout"]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows      =  ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_ADMIN_USER_PASSWORD_AUTH"]

}

resource "aws_cognito_user" "default_user_medico" {
  user_pool_id = aws_cognito_user_pool.medico_pool.id
  username     = "medico"
  password = "Fase!324"
  attributes = {
    terraform      = true
    foo            = "medico"
    email          = "jessicasalmeida@hotmail.com"
    email_verified = true
  }
}
