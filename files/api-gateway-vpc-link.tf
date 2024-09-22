resource "aws_apigatewayv2_api" "apigtw_health" {
  name = "health-apigateway"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_vpc_link" "vpclink_apig" {
  name        = "health_vpclink"
  security_group_ids = [aws_security_group.load-balancer-paciente-sg.id]
  subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Usage = "health_vpclink"
  }
}

resource "aws_apigatewayv2_stage" "stage_apig" {
  api_id = aws_apigatewayv2_api.apigtw_health.id
  name   = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "paciente_route" {
  api_id    = aws_apigatewayv2_api.apigtw_health.id
  route_key = "ANY /{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.paciente_albintegration.id}"

  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer_paciente.id
}

resource "aws_apigatewayv2_integration" "paciente_albintegration" {
  api_id           = aws_apigatewayv2_api.apigtw_health.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.ec2-alb-http-listener_paciente.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpclink_apig.id

}

resource "aws_apigatewayv2_vpc_link" "medico_vpclink" {
  name        = "medico_vpclink"
  security_group_ids = [aws_security_group.load-balancer-medico-sg.id]
  subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Usage = "medico_vpclink"
  }
}

resource "aws_apigatewayv2_route" "medico_route" {
  api_id    = aws_apigatewayv2_api.apigtw_health.id
  route_key = "ANY /doctor"
  target = "integrations/${aws_apigatewayv2_integration.ec2_medico_integration.id}"

  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer_medico.id
}
resource "aws_apigatewayv2_integration" "ec2_medico_integration" {
  api_id           = aws_apigatewayv2_api.apigtw_health.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.ec2-alb-http-listener_medico.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.medico_vpclink.id

}

resource "aws_apigatewayv2_authorizer" "authorizer_paciente" {
  api_id                            = aws_apigatewayv2_api.apigtw_health.id
  authorizer_type                   = "JWT"
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "paciente-authorizer"
  jwt_configuration {
    audience = [aws_cognito_user_pool_client.paciente_pool_cliente.id]
    issuer = "https://cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.paciente_pool.id}"
  }
  depends_on = [aws_cognito_user_pool_client.paciente_pool_cliente, aws_cognito_user_pool.paciente_pool]
}

resource "aws_apigatewayv2_authorizer" "authorizer_medico" {
  api_id                            = aws_apigatewayv2_api.apigtw_health.id
  authorizer_type                   = "JWT"
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "medico-authorizer"
  jwt_configuration {
    audience = [aws_cognito_user_pool_client.medico_pool_cliente.id]
    issuer = "https://cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.medico_pool.id}"
  }
  depends_on = [aws_cognito_user_pool_client.medico_pool_cliente, aws_cognito_user_pool.medico_pool]
}


resource "aws_apigatewayv2_integration" "login_lambda_integration_paciente" {
  api_id           = aws_apigatewayv2_api.apigtw_health.id
  integration_type = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri  = aws_lambda_function.autenticacao-paciente.arn
}

resource "aws_apigatewayv2_integration" "login_lambda_integration_medico" {
  api_id           = aws_apigatewayv2_api.apigtw_health.id
  integration_type = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri  = aws_lambda_function.autenticacao_medico.arn
}

resource "aws_apigatewayv2_route" "login_route_paciente" {
  api_id    = aws_apigatewayv2_api.apigtw_health.id
  route_key = "POST /loginpaciente"
  target = "integrations/${aws_apigatewayv2_integration.login_lambda_integration_paciente.id}"
}

resource "aws_apigatewayv2_route" "login_route_medico" {
  api_id    = aws_apigatewayv2_api.apigtw_health.id
  route_key = "POST /loginmedico"
  target = "integrations/${aws_apigatewayv2_integration.login_lambda_integration_medico.id}"
}