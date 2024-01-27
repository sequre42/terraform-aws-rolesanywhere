resource "aws_rolesanywhere_trust_anchor" "trust_anchor" {

  enabled = true
  name = var.trust_anchor_name
  source {
    source_data {
      x509_certificate_data = tls_self_signed_cert.ca_cert.cert_pem
    }
    source_type = "CERTIFICATE_BUNDLE"
  }
}

resource "aws_rolesanywhere_profile" "anywhere_user" {
  name      = var.profile_name
  role_arns = [aws_iam_role.anywhere_user.arn]
  enabled   = true
}

