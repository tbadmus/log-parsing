resource "aws_iam_role" "grace_iam_for_lambda" {
  name = "grace-${var.appenv}-cloudwatch-metric-alarm-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "grace_lambda_logging" {
  name        = "grace-${var.appenv}-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<END_OF_POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Resource": "*"
        }
    ]
}
END_OF_POLICY
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.grace_iam_for_lambda.name
  policy_arn = aws_iam_policy.grace_lambda_logging.arn
}