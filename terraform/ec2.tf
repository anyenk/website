resource "aws_instance" "wordpress" {
  ami                    = "ami-02e6c834d44f57b3e"
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.wordpress.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  key_name               = "wordpress-key"

  tags = {
    Name = "wordpress-prod"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e
    dnf update -y
    dnf install -y httpd php php-mysqlnd php-gd php-xml php-mbstring mariadb105-server wget
    systemctl enable httpd mariadb
    systemctl start httpd mariadb
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER '${var.wordpress_user}'@'localhost' IDENTIFIED BY '${var.wordpress_password}';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${var.wordpress_user}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    cd /tmp
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* /var/www/html/
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
    sed -i "s/username_here/${var.wordpress_user}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${var.wordpress_password}/" /var/www/html/wp-config.php
    chown -R apache:apache /var/www/html/
    chmod -R 755 /var/www/html/
    systemctl restart httpd
  EOF
}