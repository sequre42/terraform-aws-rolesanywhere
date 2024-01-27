resource "aws_iam_policy" "sqs_access_policy" {
  name        = var.sqs_policy_name
  description = "A policy for anywhere role to SQS access"
  policy      = data.aws_iam_policy_document.sqs_access_anywhere.json
}

data "aws_iam_policy_document" "sqs_access_anywhere" {
  statement {
    effect = "Allow"

    actions = [
		"sqs:SendMessage",
		"sqs:ReceiveMessage",
        "sqs:listqueues"
    ]

    resources = [
		"*"
    ]
	
  }
}

resource "aws_iam_role_policy_attachment" "anywhere_user" {
  role       = var.anywhere_role_name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}

