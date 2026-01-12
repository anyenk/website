
resource "cloudflare_record" "wordpress" {
  zone_id = var.cloudflare_zone
  name    = var.domain
  value   = aws_instance.wordpress.public_ip
  type    = "A"
  ttl     = 300
  proxied = false
}
