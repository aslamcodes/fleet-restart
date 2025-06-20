resource "aws_iam_role" "bulk_restart_step_function_role" {
  name = "fleet_bulk_restart_role_${local.product}"
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
resource "aws_iam_role_policy" "bulk_restart_step_function_policy" {
  name     = "fleet_bulk_restart_policy_${local.product}"
  role     = aws_iam_role.bulk_restart_step_function_role.id
  provider = aws.us-east-2

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution",
          "events:PutRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "events:DeleteRule"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "appstream:DescribeFleets"
        ]
        Resource = "*"
      },

    ]
  })
}


resource "aws_iam_role" "fleet_restart_step_function_role" {
  name = "fleet_restart_sfn_role_${local.product}-2"
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

resource "aws_iam_role_policy" "fleet_restart_step_function_policy" {
  name     = "fleet_restart_sfn_policy_${local.product}"
  role     = aws_iam_role.fleet_restart_step_function_role.id
  provider = aws.us-east-2

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "appstream:DescribeFleets",
          "appstream:StopFleet",
          "appstream:StartFleet"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogDelivery",
          "logs:CreateLogStream",
          "logs:GetLogDelivery",
          "logs:UpdateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:ListLogDeliveries",
          "logs:PutLogEvents",
          "logs:PutResourcePolicy",
          "logs:DescribeResourcePolicies",
          "logs:DescribeLogGroups"
        ],
        Resource = "*"
      }
    ],
  })
}

