## Dicas sobre o arquivo Vagrantfile

```php
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    config.vm.hostname = "sei-vagrant"
    # Habilitar o IP para conexão do host com a box:    
    config.vm.network "private_network", ip: "192.168.33.10"

    vb.memory = "2048"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    #vb.customize ["modifyvm", :id, "--memory", "4096", "--usb", "off", "--audio", "none"]
    # Quando estiver dando erro de timeout
    config.vm.boot_timeout = 600
    # Corrigindo erro na conexão do host com a box via SSH
    config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"
    
    # Executar comandos do sistema operacional ou scripts, exemplo:
    config.vm.provision "shell", inline: <<-SHELL
       apt-get update
       apt-get install -y apache2
    SHELL
  end
```
