resource "aws_iam_role" "step_function_schedule_role" {
  name = "appstream_fleet_restart_state_machine_role_${local.product}"
  # Todo: Remove this on push
  permissions_boundary = "arn:aws:iam::339713128828:policy/EnhancedPowerUserAccess"
  provider             = aws.us-east-2
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "step_function_schedule_policy" {
  name     = "appstream_fleet_restart_sfn_trigger_schedule_policy_${local.product}"
  role     = aws_iam_role.step_function_schedule_role.id
  provider = aws.us-east-2

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = "*"
      },
    ]
  })
}

# resource "aws_scheduler_schedule" "fleet_restart_schedule" {
#   name       = "fleet-restart-schedule"
#   group_name = "default"
#
#   flexible_time_window {
#     mode = "OFF"
#   }
#
#   schedule_expression = "rate(1 day)"
#
#   target {
#     arn      = aws_sfn_state_machine.bulk_restart_fleet.arn
#     role_arn = aws_iam_role.step_function_schedule_role.arn
#   }
# }
