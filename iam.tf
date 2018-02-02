resource "aws_iam_role" "ecr-repo" {
  name = "ecr-ross-account-read"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
    "AWS": "arn:aws:iam::${var.test_account_id}:root"
      },

    "Action": "sts:AssumeRole"
  }
}
EOF
}
resource "aws_iam_policy" "ecr-read" {
    name        = "ecr-ross-account-read"
    description = "ecr read policy"

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage"
            ],
                "Resource": "*"

        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecr-attach" {
    role       = "${aws_iam_role.ecr-repo.name}"
    policy_arn = "${aws_iam_policy.ecr-read.arn}"
}

