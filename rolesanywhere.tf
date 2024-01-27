module "roles-anywhere" {
    source = "./modules/terraform-aws-rolesanywhere"
    country             = var.country
    province            = var.province
    locality            = var.locality
    common_name         = var.common_name
    common_name_client  = var.common_name_client
    organization        = var.organization
    organizational_unit = var.organizational_unit
    organizational_unit_client = var.organizational_unit_client
    validity_period_hours = var.validity_period_hours  
    trust_anchor_name = "DG_Integration"
    profile_name = "DG_Integration"
    anywhere_role_name = var.anywhere_role_name
}

locals {
  ca_cert = module.roles-anywhere.ca_cert
  ca_private_key = module.roles-anywhere.ca_private_key 
  client_cert = module.roles-anywhere.client_cert
  client_key = module.roles-anywhere.client_key
  certs_save_path ="${path.module}"
  trust_anchor_arn = module.roles-anywhere.trust_anchor_arn
  profile-arn = module.roles-anywhere.profile-arn  
  role-arn = module.roles-anywhere.role-arn
}

resource "local_file" "ca_cert" {
  count = var.certs_save_to_files ? 1 : 0
  content  = local.ca_cert
  filename = "${local.certs_save_path}/rootCA.pem"
  file_permission = "0644"
}

resource "local_file" "ca_private_key" {
  count = var.certs_save_to_files ? 1 : 0
  content  = local.ca_private_key
  file_permission = "0600"
  filename = "${local.certs_save_path}/rootCA.key"
}

resource "local_file" "client_key" {
  count = var.certs_save_to_files ? 1 : 0
  content  = local.client_key
  file_permission = "0600"
  filename = "${local.certs_save_path}/client.key"
}

resource "local_file" "client_cert" {
  count = var.certs_save_to_files ? 1 : 0
  content  = local.client_cert
  filename = "${local.certs_save_path}/client.pem"
  file_permission = "0644"
}resource "aws_iam_policy" "sqs_access_policy" {
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
}variable   validity_period_hours {
  type        = string
  default     = "87660" #default 10 years
  description = "certificate validity period hours"
}

variable country {
  type        = string
  default     = "US"
  description = "certificate country"
}

variable province {
  type        = string
  default     = "IL"
  description = "certificate province"
}

variable locality {
  type        = string
  default     = "Chicago"
  description = "certificate locality"
}

variable common_name {
  type        = string
  default     = "Double Good Root CA"
  description = "certificate common_name"
}

variable common_name_client {
  type        = string
  default     = "Double Good"
  description = "certificate common_name"
}

variable organization {
  type        = string
  default     = "Double Good LP"
  description = "certificate organization"
}

variable organizational_unit {
  type        = string
  default     = "Double Good Root Certification Auhtority"
  description = "certificate organizational_unit"
}

variable "organizational_unit_client" {
  type = string
  default = "Development"
}

variable "certs_save_to_files" {
  type = bool
  default = true
}

variable "trust_anchor_name" {
  type = string
  default = "anywhere_trust_anchor"
  
}

variable "profile_name" {
  type = string
  default = "anywhere_user_profile"
}

variable "anywhere_role_name" {
  type = string
  default = "anywhere_sqs_access_role"
}

variable "sqs_policy_name" {
  type = string
  default = "anywhere_sqs_access_policy"
}

variable sqs_arn {
  type        = list
  default     = [
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-erp-order",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-erp-order-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-erp-payout",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-erp-payout-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-order-changed",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-order-changed-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-payout-sent",
        "https://sqs.us-east-1.amazonaws.com/432369403451/dev-dg-erp-gateway-payout-sent-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/prod-dg-erp-gateway-erp-order",
        "https://sqs.us-east-1.amazonaws.com/432369403451/prod-dg-erp-gateway-erp-order-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/prod-dg-erp-gateway-order-changed",
        "https://sqs.us-east-1.amazonaws.com/432369403451/prod-dg-erp-gateway-order-changed-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/staging-dg-erp-gateway-erp-order",
        "https://sqs.us-east-1.amazonaws.com/432369403451/staging-dg-erp-gateway-erp-order-dlq",
        "https://sqs.us-east-1.amazonaws.com/432369403451/staging-dg-erp-gateway-order-changed",
        "https://sqs.us-east-1.amazonaws.com/432369403451/staging-dg-erp-gateway-order-changed-dlq",
  ]
  description = "SQS ERP queues"
}
