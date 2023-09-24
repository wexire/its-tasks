resource "aws_iam_role" "its-exec-role" {
  name = "its-exec-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "its-exec-attach" {
  name = "its-exec-attach"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  roles = [ aws_iam_role.its-exec-role.name ]
}