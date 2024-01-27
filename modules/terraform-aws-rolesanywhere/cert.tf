resource "tls_private_key" "client" {
  algorithm = "RSA"
}

resource "tls_cert_request" "client_csr" {

  private_key_pem = tls_private_key.client.private_key_pem


  subject {
    country             = var.country
    province            = var.province
    locality            = var.locality
    organizational_unit = var.organizational_unit_client
    common_name         = var.common_name_client
    organization        = var.organization
  }
}

# Sign Seerver Certificate by Private CA 
resource "tls_locally_signed_cert" "client" {
  is_ca_certificate = false
  // CSR by the development servers
  cert_request_pem = tls_cert_request.client_csr.cert_request_pem
  // CA Private key 
  ca_private_key_pem = tls_private_key.ca_private_key.private_key_pem
  // CA certificate
  ca_cert_pem = tls_self_signed_cert.ca_cert.cert_pem

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "digital_signature"
  ]
}

