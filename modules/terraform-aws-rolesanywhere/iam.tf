resource "aws_iam_role" "anywhere_user" {
  name = var.anywhere_role_name

  assume_role_policy = data.aws_iam_policy_document.anywhere_role.json

  tags = {
    Team = "DevOps"
  }
}

data "aws_iam_policy_document" "anywhere_role" {

    statement {
		effect = "Allow"
		principals {
      		type        = "Service"
      		identifiers = ["rolesanywhere.amazonaws.com"]
    		}
		actions = [
			"sts:AssumeRole",
			"sts:TagSession",
			"sts:SetSourceIdentity",
		]
		condition {
			test = "StringEquals"
			variable = "aws:PrincipalTag/x509Subject/OU"
			values = [ var.organizational_unit_client]
		}
		condition {
			test = "ArnEquals"
			variable = "aws:SourceArn"
			values = [aws_rolesanywhere_trust_anchor.trust_anchor.arn]
		}
	}
}