# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "groupdate-devbox"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.provision :shell, path: File.join(File.expand_path("..", __FILE__), "provision.sh"), keep_color: true
end
