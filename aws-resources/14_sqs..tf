resource "aws_sqs_queue" "sqs_iaac" {
  name = "sqs_queue"
  delay_seconds = 9
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  tags = {
    name="terraform project"
    description = "managed by terraform provisioning"
  }
}

