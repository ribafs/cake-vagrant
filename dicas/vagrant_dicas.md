## Dicas sobre o Vagrant

Quando você começa a trabalhar com programação, é a principio normal que sua máquina fique um pouco bagunçada. Bibliotecas pra cá, interpretadores pra lá, compiladores ali, e assim vai. Depois de algum tempo, você até se encontra de forma que consegue usar tudo o que você mesmo colocou e dessa forma consegue fazer o que quer, ou seja, programar. O problema é quando você precisa efetivamente replicar este mesmo ambiente em outras máquinas, como a máquina dos seus colegas de trabalho,  por exemplo, ou quando você por algum motivo perde todos os dados da máquina (como quando o HD resolve pifar, o que costuma acontecer com certa frequência, pelo que vejo).

O Vagrant é, em poucas palavras, uma ferramenta para criar e distribuir ambientes de desenvolvimento. Com esse propósito, sua real utilidade se mostra mais clara: Facilitar o trabalho do desenvolvedor no teste de suas aplicações, permitindo simular um ambiente mais fiel ao que será usado efetivamente em produção, além de permitir o compartilhamento deste ambiente com outros desenvolvedores. Tudo isso é feito com o uso de uma máquina virtual, que isola todo um hardware virtual a partir da sua máquina física real, além de permitir uso de sistema operacional e softwares próprios, por exemplo.

Um programador PHP, por exemplo, pode configurar a máquina para instalar o PHP, Apache e MySQL da mesma forma que este o faria em um servidor real. E, ainda: usando o mesmo sistema operacional do servidor real. Mas...qual a diferença entre usar o Virtualbox diretamente e o Vagrant, nesse caso? Bom, usando o Vagrant, o desenvolvedor consegue facilmente fazer configurações como redirecionamento de portas (importante para um programador que trabalha com web), sincronizar pastas entre a sua máquina física real e a máquina virtual de desenvolvimento e provisionar a máquina virtual automaticamente de acordo com a sua vontade. Tudo isso usando apenas alguns poucos arquivos de configuração e sem precisar repetir procedimentos frequentemente. No fim, o Vagrant se destaca pela facilidade de distribuição e manutenção das máquinas virtuais, garantindo assim um ambiente de desenvolvimento eficiente e fácil de replicar.

Crédito - https://fjorgemota.com/vagrant-maquinas-virtuais-automatizadas-para-desenvolvimento/

## Dicas sobre o vagrant

### Instalar o VirtualBox e o Extension Pack
https://www.virtualbox.org/wiki/Downloads

### Instalar o git
- Linux - sudo apt install git
- Windows - https://git-scm.com/download/win

### Instalar o Vagrant
http://vagrantup.com

### Procurando por boxes na cloud:
https://app.vagrantup.com/boxes/search

### Crie uma pasta para as boxes
mkdir /home/ribafs/vagrant

### Criar uma pasta para a box cake-vagrant
mkdir /home/ribafs/vagrant/cake-vagrant

### Instalar a box cake-vagrant:
```php
cd /home/ribafs/vagrant
mkdir cake-vagrant
cd cake-vagrant
vagrant init ribafs/cake-vagrant --box-version 1.3
vagrant up

vagrant ssh-config
```
Adicionar para o Vagrantfile, caso não conecte do host para a box via ssh:

config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"

Dicas encontrada em https://github.com/hashicorp/vagrant/issues/10280#issuecomment-437276971

Após editr o Vagrantfile execute:
```php
vagrant reload
ssh vagrant@192.168.30.10
ou
ssh -p 2222@127.0.0.1
passwod: vagrant
```
Também podemos acessar pelo ambiente gráfico usando o nemo/nautilus no Linux ou o WinSCP no Windows
```php
Servidor - 127.0.0.1
Porta - 2222
Pasta - /vagrant ou /var/www/html
Usuário - vagrant
Senha - vagrant
```
Executar comandos do SO ou scripts shell através do Vagrantfile, ver ao fnal:

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

vagrant status
ssh -p 2222 vagrant@localhost 'sudo shutdown -h now'
vagrant global-status
vagrant destroy 5d24c9b

### Levantar
vagrant up --provider=virtualbox

### Acessar a box instalada e upada
vahrant ssh

### Exportando uma box
```php
cd /vagrant/boxnaome
vagrant box update
vagrant halt
vagrant package --output nome.box
```
### Para corrigir problemas Instalar vghuest
```php
vagrant plugin install vagrant-vbguest

cd /vagrant/boxname
vagrant box update
```
### Adicionando nova rede

Editar o Vagrantfile e descomentar e ajustar a linha:

  config.vm.network "private_network", ip: "192.168.33.10"

Com isso podemos acessar a box do host com:

http://192.168.33.10

ssh vagrant@192.168.33.10

scp arquivo.zip vagrant@192.168.33.10:/tmp


