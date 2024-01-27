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

variable   validity_period_hours {
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
  default     = "Sequre42 Root CA"
  description = "certificate common_name"
}

variable common_name_client {
  type        = string
  default     = "Sequre42"
  description = "certificate common_name"
}

variable organization {
  type        = string
  default     = "Sequre42"
  description = "certificate organization"
}

variable organizational_unit {
  type        = string
  default     = "Sequre42 Root Certification Auhtority"
  description = "certificate organizational_unit"
}

variable "organizational_unit_client" {
  type = string
  default = "Development"
}
