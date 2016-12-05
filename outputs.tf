# name of the EC2 CloudWatch Only role
output "ec2_cloudwatch_role" {
  value = "${aws_iam_role.cw.name}"
}

# name of the EC2 CloudWatch+Tag modification role
output "ec2_cloudwatch_tagger_role" {
  value = "${aws_iam_role.cw_tagger.name}"
}

# name of the default root key
output "default_root_key" {
  value = "${aws_key_pair.root.key_name}"
}
