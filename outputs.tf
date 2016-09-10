output "ec2_cloudwatch_role" {
  value = "${aws_iam_role.cw.name}"
}

output "ec2_cloudwatch_tagger_role" {
  value = "${aws_iam_role.cw_tagger.name}"
}