resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.name}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["autoscaling:UpdateAutoScalingGroup"],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : ["secretsmanager:GetSecretValue"],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.name}-lambda-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}