# S3 bucket for logging
resource "aws_s3_bucket" "lb_logs" {
  bucket = var.project_log_key
}

resource "aws_s3_bucket_policy" "allow_alb" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = data.aws_iam_policy_document.allow_alb.json
}

data "aws_iam_policy_document" "allow_alb" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["127311923021"]
    }

    actions = ["s3:PutObject"]
    effect = "Allow"
    resources = [
      aws_s3_bucket.lb_logs.arn,
      "${aws_s3_bucket.lb_logs.arn}/*",
    ]
  }
}