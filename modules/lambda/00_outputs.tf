output "arn" {
  value = aws_lambda_function.this.arn
}

output "source_code_hash" {
  value = aws_lambda_function.this.source_code_hash
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}
