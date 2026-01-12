resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  content = aws_eip.wordpress.public_ip
  type    = "A"
  proxied = true
  ttl     = 1  # Auto cuando proxied = true
}

# Registro www
resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  content = aws_eip.wordpress.public_ip
  type    = "A"
  proxied = true
  ttl     = 1
}