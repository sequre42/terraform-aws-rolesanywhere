output ca_private_key {
  value       = tls_private_key.ca_private_key.private_key_pem
  sensitive   = false
}

output ca_cert {
  value       = tls_self_signed_cert.ca_cert.cert_pem
  sensitive   = false
}

output client_cert {
  value       = tls_locally_signed_cert.client.cert_pem
  sensitive   = false
}

output client_key {
  value       = tls_private_key.client.private_key_pem
  sensitive   = false
}

output "trust_anchor_arn" {
  value = aws_rolesanywhere_trust_anchor.trust_anchor.arn
  sensitive = false
}

output profile-arn {
  value       = aws_rolesanywhere_profile.anywhere_user.arn
  sensitive   = false
}

output role-arn {
  value       = aws_iam_role.anywhere_user.arn
  sensitive   = false
}
