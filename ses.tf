resource "aws_ses_email_identity" "example" {
  email = var.email_address
}