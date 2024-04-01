# SQS queue creation in Account B
resource "aws_sqs_queue" "profile_picture_s3_events" {
  provider                  = aws.destination_acc # Specify the "dst" provider for this resource
  name                      = var.aws_sqs_queue_name
  delay_seconds             = var.sqs_delay_seconds
  max_message_size          = var.sqs_max_message_size
  message_retention_seconds = var.sqs_message_retention_seconds
  receive_wait_time_seconds = var.sqs_receive_wait_time_seconds
  depends_on                = [aws_sns_topic.topic_subscription]
}

resource "aws_sqs_queue_policy" "profile_picture_sqs_policy" {
  queue_url = aws_sqs_queue.profile_picture_s3_events.id

policy = jsonencode({
    Version   = "2012-10-17",
    Id        = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__owner_statement",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action    = "SQS:*",
        Resource  = aws_sqs_queue.profile_picture_s3_events.arn
      },
      {
        Sid       = "AllowSnsToSendMessage",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action    = "SQS:SendMessage",
        Resource  = aws_sqs_queue.profile_picture_s3_events.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.topic_subscription.arn
          }
        }
      }
    ]
  })
}


resource "aws_sns_topic" "topic_subscription" {
  name = var.aws_sns_topic_name
}

resource "aws_sns_topic_policy" "test_topic_policy" {
  arn    = aws_sns_topic.topic_subscription.arn
  policy = jsonencode({
    Version   = "2008-10-17",
    Id        = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource  = aws_sns_topic.topic_subscription.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = "463466179279"
          }
        }
      },
      {
        Sid       = "example-statement-ID",
        Effect    = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action    = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource  = aws_sns_topic.topic_subscription.arn,
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "677944337604"
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:s3:::arlo-onecloud-profilepic"
          }
        }
      }
    ]
  })
}


resource "aws_sns_topic_subscription" "test_topic_subscription" {
  topic_arn = aws_sns_topic.topic_subscription.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.profile_picture_s3_events.arn
  depends_on = [aws_sqs_queue.profile_picture_s3_events]
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role_for_s3_sns_sqs"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

resource "aws_lambda_function" "s3-oc_sns_lambda_cw" {
  function_name = var.lambda_function_name

  filename  = "lambda_function.zip"
  handler   = "lambda_function.lambda_handler"
  runtime   = "python3.10"
  role      = aws_iam_role.lambda_execution_role.arn
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.topic_subscription.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.s3-oc_sns_lambda_cw.arn
}

resource "aws_lambda_permission" "allow_sns_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3-oc_sns_lambda_cw.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.topic_subscription.arn
}

data "aws_s3_bucket" "existing_bucket" {
  bucket = var.existing_s3_bucket_name
}


resource "aws_s3_bucket_notification" "bucket_notification1" {
  bucket = data.aws_s3_bucket.existing_bucket.id

  topic {
    id            = var.aws_sns_topic_name
    topic_arn     = aws_sns_topic.topic_subscription.arn
    events        = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }

  depends_on =  [aws_sqs_queue_policy.profile_picture_sqs_policy]
  provider = aws.source_acc
}