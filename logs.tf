resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.api-gateway-cloudwatch-role.arn
}

resource "aws_iam_role" "api-gateway-cloudwatch-role" {
  name = local.resource_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.api-gateway-cloudwatch-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}