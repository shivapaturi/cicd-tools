variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "zone_name" {
  type        = string
  default     = "mydaws.site"
  description = "description"
}

variable "zone_id" {
  type        = string
  default     = "Z094207310Q2WY9TY0PKH"
  description = "description"
}