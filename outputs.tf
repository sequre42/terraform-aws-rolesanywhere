output ca_private_key {
  value       = local.ca_private_key
  sensitive   = true
}

output ca_cert {
  value       = local.ca_cert
  sensitive   = true
}

output client_cert {
  value       = local.client_cert
  sensitive   = true
}

output "trust_anchor_arn" {
  value = local.trust_anchor_arn
  sensitive = false
}

output client_key {
  value       = local.client_key
  sensitive   = true
}

output profile-arn {
  value       = local.profile-arn
  sensitive   = false
}

output role-arn {
  value       = local.role-arn
  sensitive   = false
}