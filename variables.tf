variable "appenv" {
  type        = string
  description = "(optional) The environment in which the script is running (development | test | production)"
  default     = "development"
}

variable "email_address" {
  default = "grace-dev-alerts"
}

variable "recipients" {
  type        = string
  description = "(required) comma delimited list of AWS SES eMail recipients"
  default     = "grace-dev-alerts"
}

variable "sender" {
  type        = string
  description = "(required) eMail address of sender for AWS SES"
}

variable "subject" {
  type        = string
  description = "Subject Header of  Email sent notifications"
  default     = "Grace logging email"
}

variable "region" {
  description = "AWS region to deploy lambda function."
  default     = "us-east-1"
}

variable "s3_bucket" {
  type        = string
  description = "(required) S3 bucket name/id where config service histories and snapshots are saved"
}

variable "kms_key_arn" {
  type        = string
  description = "(required) ARN of KMS key to decrypt config service histories and snapshots"
}