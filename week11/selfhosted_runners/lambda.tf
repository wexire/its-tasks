module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.name}-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  create_role   = false
  lambda_role   = aws_iam_role.lambda_role.arn
  environment_variables = {
    SECRET_NAME               = "cci-secrets",
    SECRET_REGION             = var.region,
    AUTO_SCALING_MAX          = 3,
    AUTO_SCALING_GROUP_NAME   = module.asg.autoscaling_group_name,
    AUTO_SCALING_GROUP_REGION = var.region
  }

  source_path = "python"

  tags = {
    Name = "${var.name}-lambda"
  }
}