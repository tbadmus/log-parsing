# Lambda subscription to CloudWatch log group
resource "aws_lambda_permission" "grace-app-allow-cloudwatch" {
  statement_id  = "grace-app-allow-cloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.logging_lambda.arn
  principal     = "logs.${var.region}.amazonaws.com"
  source_arn    = module.logging.cloudtrail_log_group_arn
}

resource "aws_cloudwatch_log_subscription_filter" "grace-app-cloudwatch-sumologic-lambda-subscription" {
  depends_on      = [aws_lambda_permission.grace-app-allow-cloudwatch]
  name            = "cloudwatch-grace-lambda-subscription"
  log_group_name  = module.logging.cloudtrail_log_group_name
  filter_pattern  = ""
  destination_arn = aws_lambda_function.logging_lambda.arn
}
