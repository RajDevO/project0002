variable "existing_s3_bucket_name" {
  description = "Name of the existing S3 bucket in Account onecloud-dev"
  type        = string
  default = "arlo-onecloud-profilepic"
}

variable "SourceAccount" {
  description = "SourceAccount"
  type = number
  default = 677944337604
}

variable "aws_region_s3" {
  description = "S3 bucket region"
  type = string
  default = "eu-west-1"
}

variable "aws_iam_role_s3" {
  description = "s3 assume role"
  type = string
  default = "arn:aws:iam::677944337604:role/EC2toEKS"
}

variable "aws_region_sqs" {
  description = "sqs region"
  type = string
  default = "eu-west-1"
}

variable "aws_iam_role_sqs" {
  description = "sqs assume role"
  type = string
  default = "arn:aws:iam::463466179279:role/EC2toEKS"
}

variable "aws_sqs_queue_name" {
  description = "sqs queue name"
  type = string
  default = "profile_picture_s3_events"
}

variable "sqs_delay_seconds" {
  description = "sqs delay seconds"
  type = number
  default = 10
}

variable "sqs_max_message_size" {
  description = "sqs max message size"
  type = number
  default = 2048
}

variable "sqs_message_retention_seconds" {
  description = "sqs message retention seconds"
  type = number
  default = 86400
}

variable "sqs_receive_wait_time_seconds" {
  description = "sqs receive wait time seconds"
  type = number
  default = 10
}

variable "aws_sns_topic_name" {
  description = "sns topic name"
  type = string
  default = "profile_picture_s3_events_sns"
}

variable "lambda_function_name" {
  description = "lambda function"
  type = string
  default = "lambda_profile_picture_CW_log"
}