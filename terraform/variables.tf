
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

variable "allowed_ssh_ips" {
  type    = list(string)
  default = [
    "201.187.41.147/32",  # Anibal
    "190.22.13.176/32",   # Benja
  ]
}
