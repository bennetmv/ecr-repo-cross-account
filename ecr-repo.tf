resource "aws_ecr_repository" "foo" {
  name = "bar"
}

resource "aws_ecr_repository_policy" "foopolicy" {
repository = "${aws_ecr_repository.foo.name}"

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
         "Sid": "ecr-read",
            "Effect": "Allow",
             "Principal": {
        "AWS": "arn:aws:iam::${var.test_account_id}:root"
      },
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage"
            ]
                    }
    ]
}
EOF
}
resource "aws_ecr_lifecycle_policy" "foopolicy" {
  repository = "${aws_ecr_repository.foo.name}"

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
