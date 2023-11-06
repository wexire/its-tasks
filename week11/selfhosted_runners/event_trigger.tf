resource "aws_cloudwatch_event_rule" "cci_runner_scheduled_trigger" {
  name                = "cci-runner-scheduled-trigger"
  description         = "Schedule Lambda function execution every minute"
  schedule_expression = "cron(0/1 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "cci_attach_lambda_target" {
  rule      = aws_cloudwatch_event_rule.cci_runner_scheduled_trigger.name
  target_id = module.lambda_function.lambda_function_name
  arn       = module.lambda_function.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cci_runner_scheduled_trigger.arn
}