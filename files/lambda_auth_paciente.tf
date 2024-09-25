resource "aws_lambda_function" "autenticacao-paciente" {
  filename      = "../lambda.zip"
  function_name = "loginpaciente"
  role          = var.labRole
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # Define as variáveis de ambiente
  environment {
    variables = {
      USER_POOL_ID   = aws_cognito_user_pool.paciente_pool.id
      CLIENT_ID      = aws_cognito_user_pool_client.paciente_pool_cliente.id
      REGION = var.region
      ACCESS_KEY_ID = var.access_key
      SECRET_ACCESS_KEY = var.secret_key
      TOKEN = var.token
    }
  }
}

resource "aws_lambda_permission" "apigw_paciente" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.autenticacao-paciente.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.apigtw_health.execution_arn}/*"
}