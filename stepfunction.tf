
# TODO:
# - If there's only one fleet, the bulk state machines fails as it expects an arrya, but gets a string  
# - When creating, apply the roles BEFORE creating the step functions as it Results in errors

resource "aws_sfn_state_machine" "bulk_restart_fleet" {
  depends_on = [aws_sfn_state_machine.fleet_restart]
  provider   = aws.us-east-2
  role_arn   = aws_iam_role.bulk_restart_step_function_role.arn
  name       = "fleet_restart_controller_state_machine"
  definition = templatefile("${path.module}/definitions/fleet-restart-controller.json", {
    fleet_restart_sfn_state_machine_arn = aws_sfn_state_machine.fleet_restart.arn
  })
}

resource "aws_sfn_state_machine" "fleet_restart" {
  provider = aws.us-east-2
  role_arn = aws_iam_role.fleet_restart_step_function_role.arn
  name     = "fleet_restart_state_machine"
  definition = templatefile("${path.module}/definitions/fleet-restart.json", {
    sns_resource_arn = aws_sns_topic.restart-alerts.arn
  })
}

