#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 16.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                1 'Atualizar repositórios' \
                2 'Instalar LAMP e outros' \
                0 'Sair' )
    case $servico in
      1) apt update;;
      2) clear;
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt install -y apache2 libapache2-mod-php7.2 aptitude git mc;

# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt install -y mysql-server postgresql sqlite3;

# NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt install -y nodejs        

# "Instalar PHP 7 e extensões. Tecle Enter para instalar!";
apt install -y php7.2-bcmath php7.2 mcrypt php7.2-gd php7.2-mysql php7.2-pgsql php7.2-sqlite;
apt install -y php-pear php7.2-xml php7.2-xsl curl php7.2-curl phpunit php-xdebug php7.2-intl composer;
apt install -y php7.2-zip php7.2-mbstring php-gettext php-mbstring php7.2-fpm;
phpenmod mbstring;

# "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
apt install -y php-apcu;

wget http://spout.ussg.indiana.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.5.10-0ubuntu1_amd64.deb;
dpkg -i memcached_1.5.10-0ubuntu1_amd64.deb;
apt install -y php-memcache;

wget https://github.com/vrana/adminer/releases/download/v4.7.1/adminer-4.7.1.php;
mv adminer-4.7.1.php /var/www/html/adminer.php

systemctl restart apache2;
a2enmod rewrite;

apt update;
apt upgrade -y;;
      0) clear;exit;;
   esac
done
