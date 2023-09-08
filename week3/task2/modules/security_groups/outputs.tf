output "INSTANCE_SG_ID" {
  value = aws_security_group.its-instance-sg.id
}

output "LB_SG_ID" {
  value = aws_security_group.its-lb-sg.id
}