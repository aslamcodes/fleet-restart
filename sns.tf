resource "aws_sns_topic" "restart-alerts" {
  name = "sns-${local.product}-restart-alerts"
}
