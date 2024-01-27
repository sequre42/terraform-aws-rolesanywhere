resource "tls_private_key" "ca_private_key" {
  algorithm = "RSA"
}


resource "tls_self_signed_cert" "ca_cert" {
  private_key_pem = tls_private_key.ca_private_key.private_key_pem

  is_ca_certificate = true

  subject {
    country             = var.country
    province            = var.province
    locality            = var.locality
    common_name         = var.common_name
    organization        = var.organization
    organizational_unit = var.organizational_unit
  }

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "digital_signature",
    "cert_signing",
    "crl_signing",
  ]
}