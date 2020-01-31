resource "aws_lambda_function" "logging_lambda" {
  filename         = data.archive_file.lambda_zip_inline.output_path
  source_code_hash = data.archive_file.lambda_zip_inline.output_base64sha256
  function_name    = "aws_cloudwatch_ses_alert_lambda"
  role             = aws_iam_role.grace_iam_for_lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  timeout          = 500
  kms_key_arn      = var.kms_key_arn
  environment {
    variables = {
      TO_EMAIL   = var.recipients
      FROM_EMAIL = var.sender
      SUBJECT    = var.subject
      REGION     = var.region
    }
  }
}

data "archive_file" "lambda_zip_inline" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_inline.zip"
  source_file = "${path.module}/handler/lambda_function.py"
}