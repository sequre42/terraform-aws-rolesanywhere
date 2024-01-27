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
}