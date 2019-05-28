## Algumas dicas para o Vagrantfile

```php
  config.vm.hostname = "sei-vagrant"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./www", "/var/www/html"

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    #vb.customize ["modifyvm", :id, "--memory", "4096", "--usb", "off", "--audio", "none"]
    # Quando estiver dando erro de timeout
    config.vm.boot_timeout = 600
  end

```