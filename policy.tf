provider "aws" {
  profile = "personal"
}

resource "aws_iam_policy" "cw" {
  name_prefix = "CloudWatchLogsWriter"
  path        = "/"
  description = "Allows pushing events to CloudWatch Logs"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF
}

resource "aws_iam_policy" "tagger" {
  name_prefix = "EC2TagWriter"
  path        = "/"
  description = "Allows full control over EC2 tags"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateTgs",
        "ec2:DeleteTags",
        "ec2:DescribeInstances"
    ],
      "Resource": [
        "*"
    ]
  }
 ]
}
EOF
}

resource "aws_iam_role" "cw" {
  name_prefix = "EC2_General"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = "${aws_iam_role.cw.name}"
  policy_arn = "${aws_iam_policy.cw.arn}"
}

resource "aws_iam_role" "cw_tagger" {
  name_prefix = "EC2_CW+Tags"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cw_to_cw_tagger" {
  role       = "${aws_iam_role.cw_tagger.name}"
  policy_arn = "${aws_iam_policy.tagger.arn}"
}

resource "aws_iam_role_policy_attachment" "tagger_to_cw_tagger" {
  role       = "${aws_iam_role.cw_tagger.name}"
  policy_arn = "${aws_iam_policy.cw.arn}"
}
