# Criação de box para Vagrant com Ubuntu 18.04

Box criada de https://app.vagrantup.com/ubuntu/boxes/bionic64

Na minha máquina criei uma pasta para as boxes do Vagrant em:

/home/ribafs/vagrant

Então criei uma pasta para esta nova box em:

/home/ribafs/vagrant/ub1804min
```php
vagrant init ubuntu/bionic64
vagrant up
vagrant ssh
```
Ao final da instalação automaticamente a box atualiza o sistema operacional.

Inicialmente a box exportada ficou com

518 MB após exportada

Executar:
```php
reboot
```
## Softwares Instalados:

- apache2 com mod_rewrite
- aptitude
- git
- mc (gerenciador de arquivos em modo texto)
- composer
- mcrypt
- curl

- mysql 5.7
- postgresql 10.8
- sqlite3
- nodejs 12 com npm
- adminer.php

## Módulos do PHP:

- php7.2-bcmath php7.2-gd php7.2-mysql php7.2-pgsql php7.2-sqlite
- php-pear php7.2-xml php7.2-xsl php7.2-curl phpunit php-xdebug php7.2-intl
- php7.2-zip php7.2-mbstring php-gettext php-mbstring php7.2-fpm php-apcu php-memcache

Todos instalados com o script ub1804.sh

Apenas copiei o script ub1804.sh para a pasta /home/ribafs/vagrant/ub1804min no meu host, que é mapeada para /vagrant na box

Veja o conteúdo do script ub1804.sh em:

https://github.com/ribafs/cake-vagrant, na pasta scripts

Acessar a box com:

cd /home/ribafs/vagrant/ub1804min

## Mudar o nome do hostname
```php
vagrant up
vagrant ssh
sudo hostname ub18
exit
vagrant ssh
```

E executando:
```php
vagrant up
vagrant ssh
cd /vagrant
```

Então executei o script com
```php
sudo sh ub1804.sh
```
- Executei a primeira opção para atualizar
- Executei a segunda opção para instalar os pacotes
- Sai

## Configurar o apache e o php:
```php
sudo nano /etc/php/7.2/apache2/php.ini
```
## Configurar a exibição de erros em desenvolvimento para mostrar as mensagens de eero:
```php
display_errors = On)
```

## Configurar apache
```php
sudo nano /etc/apache2/apache2.conf
```
Adicionar a linha:
```php
ServerName localhost
```
Trocar None por All, deixando assim
```php
<Directory />
        Options FollowSymLinks
        AllowOverride All 
        Require all denied
</Directory>

<Directory /usr/share>
        AllowOverride All 
        Require all granted
</Directory>

<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride All 
        Require all granted
</Directory>
```

Reiniciar apache
```php
sudo service apache2 restart
```
## Ajustes no MySQL
O mysql no Ubuntu 18.04 vem para apenas acesso com sudo. Ajustando isso:

Conectado na box execute:
```php
sudo mysql -uroot
USE mysql;
UPDATE user SET plugin='mysql_native_password' WHERE User='root';
UPDATE user SET authentication_string=PASSWORD("root") WHERE User='root';
UPDATE user SET plugin="mysql_native_password" WHERE User='root';
FLUSH PRIVILEGES;
exit;

sudo service mysql restart

mysql -uroot -proot

Agora o MySQL tem:

- Login - root
- Senha - root

## Ajustes no PostgreSQL

Conectado na box
```php
sudo su
su - postgres
psql
alter role postgres password 'postgres';
\q
nano /etc/postgresql/10/main/pg_hba.conf

Mude esta linha
local   all             postgres                                peer

Para
local   all             postgres                                md5

Salve e feche
exit
service postgresql restart
```
## Acesse o mysql com o adminer e acesse o postgres:

http://192.168.33.10/adminer.php

## PostgreSQL

- Usuário - postgres
- Senha - postgres

## Saia e acesse o mysql

http://192.168.33.10/adminer.php

- Login - root
- Senha - root

## Copiar os scripts cake.sh e perms.sh do host para a pasta

/home/ribafs/vagrant/ub1804min:

Para que fiquem disponíveis na pasta /vagrant da box

Para ver o conteúdo dos scripts veja em

https://github.com/ribafs/cake-vagrant

## Acessar a box:
```php
vagrant up
vagrant ssh

cd /vagrant
```
Copiar na box os 3 scripts para a pasta scripts

mkdir /home/vagrant/scripts

## Adicionando ao path
Copiar os dois scripts (cake.sh e perms.sh) para /usr/local/bin para que fiquem no path e estejam acessíveis de qualquer pasta com mais facilidade.
```php
sudo cp cake.sh /usr/local/bin
sudo chmod +x /usr/local/bin/cake.sh

sudo cp perms.sh /usr/local/bin
sudo chmod +x /usr/local/bin/perms.sh
```
## Criar alias cdv
```php
nano ~/.bashrc

Adicione a linha abaixo:

alias cdv='cd /var/www/html'
```
Agora sempre que acessar a box e desejar ir para /var/www/html, basta executar

cdv

O cake.sh é para a criação de aplicativos CakePHP, assim:
```php
cd /var/www/html (ou apenas cdv)
sudo perms.sh
cake.sh nomeaplicativo
```
O perms.sh serve para ajustar as permissões do /var/www/html, caso necessário. Usar assim:

Para ajustar todo o /var/www/html, apenas

sudo perms.sh

Para ajustar um subdiretório de /var/www/html digite

sudo perms.sh nomeSubdir

## Adicionar user vagrant para o grupo www-data

sudo adduser vagrant www-data

## Aumentar a memória RAM da box para 2048:

- Edite o Vagrantfile, alterando as linhas abaixo:
```php
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
```
## Após qualquer alteração do Vagrantfile devemos executar:

vagrant up --provision

## Exportar a box atual (ub1804min) como cake-vagrant-1.0.box:

vagrant package -o cake-vagrant-1.0.box

Agora podemos usar esta box para distribuir para colegas, oferecer para download num site, mas idealmente enviar para a nuvem no site do Vagrant:

https://app.vagrantup.com/session


