output "api_endpoint" {
  description = "The HTTP API endpoint URL."
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "lambda_function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.hello.function_name
}

output "lambda_execution_role_arn" {
  description = "The ARN of the Lambda execution role."
  value       = aws_iam_role.lambda_exec.arn
}
