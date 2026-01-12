resource "aws_instance" "wordpress" {
  ami                    = "ami-02e6c834d44f57b3e"
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.wordpress.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "wordpress-prod"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Actualizar sistema
    dnf update -y

    # Instalar dependencias
    dnf install -y httpd php php-mysqlnd php-gd php-xml php-mbstring mariadb105-server wget

    # Iniciar servicios
    systemctl enable httpd mariadb
    systemctl start httpd mariadb

    # Configurar MariaDB
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'WpPassword123!';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

    # Descargar WordPress
    cd /tmp
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* /var/www/html/

    # Configurar WordPress
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
    sed -i "s/username_here/wpuser/" /var/www/html/wp-config.php
    sed -i "s/password_here/WpPassword123!/" /var/www/html/wp-config.php

    # Permisos
    chown -R apache:apache /var/www/html/
    chmod -R 755 /var/www/html/

    # Reiniciar Apache
    systemctl restart httpd
  EOF
}