output "ec2_cloudwatch_role" {
  value = "${aws_iam_role.role.name}"
}
