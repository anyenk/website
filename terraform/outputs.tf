
output "wordpress_ip" {
  description = "IP pública de la instancia EC2 de WordPress"
  value       = aws_instance.wordpress.public_ip
}
