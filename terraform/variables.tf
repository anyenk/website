
variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "domain" {
  type = string
}

variable "cloudflare_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}
