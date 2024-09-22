resource "aws_sns_topic" "send_schedule_notification" {
  name = "send_schedule_notification"
  policy =  jsonencode({
    Version = "2008-10-17"
    Id      = "__default_policy_ID"
    Statement = [
      {
        Sid      = "__default_statement_ID"
        Effect   = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ]
        Resource = aws_sns_topic.send_schedule_notification.arn
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = var.accountId
          }
        }
      },
      {
        Sid      = "__console_pub_0"
        Effect   = "Allow"
        Principal = {
          AWS = var.labRole
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.send_schedule_notification.arn
      },
      {
        Sid      = "__console_sub_0"
        Effect   = "Allow"
        Principal = {
          AWS = var.labRole
        }
        Action   = "SNS:Subscribe"
        Resource = aws_sns_topic.send_schedule_notification.arn
      }
    ]
  })
}


locals {
  snsArn     = aws_sns_topic.send_schedule_notification.arn
}

output "snsArn" {
  value = local.snsArn
}