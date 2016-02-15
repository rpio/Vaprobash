# -*- mode: ruby -*-
# vi: set ft=ruby :


# Config Github Settings
github_username = "rpio"
github_repo     = "Vaprobash"
github_branch   = "master"
github_url      = "https://raw.githubusercontent.com/#{github_username}/#{github_repo}/#{github_branch}"



# Server Configuration

hostname        = "devbox.local"

# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_ip             = "192.168.22.10"
server_cpus           = "2"   # Cores
server_memory         = "2048" # MB
server_swap           = "4096" # Options: false | int (MB) - Guideline: Between one or two times the server_memory

# UTC        for Universal Coordinated Time
# EST        for Eastern Standard Time
# CET        for Central European Time
# US/Central for American Central
# US/Eastern for American Eastern
server_timezone  = "UTC"

public_folder         = "/vagrant"



Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1504"
  config.vm.hostname = hostname
  #config.vm.network :private_network, ip: "10.10.77.11"
  config.hostmanager.aliases = %w(devbox.local devbox)

  if Vagrant.has_plugin?("vagrant-auto_network")
    config.vm.network :private_network, :ip => "0.0.0.0", :auto_network => true
  else
    config.vm.network :private_network, ip: server_ip
    config.vm.network "forwarded_port", guest: 2376, host: 2376, auto_correct: true
  end

  # Enable agent forwarding over SSH connections
  config.ssh.forward_agent = true


  # Use NFS for the shared folder
  config.vm.synced_folder ".", "/vagrant",
    id: "core",
    :nfs => true,
    :mount_options => ['nolock,vers=3,udp,noatime,actimeo=2,fsc']

  #config.vm.synced_folder ".", "#{`pwd`.chomp}"
  #config.vm.synced_folder ".", "/Users/boxb77/DevLab"

  config.vm.provision "shell", path: "#{github_url}/scripts/base.sh", args: [github_url, server_swap, server_timezone]

  # optimize base box
  config.vm.provision "shell", path: "#{github_url}/scripts/base_box_optimizations.sh", privileged: true

  # Provision PHP
  #config.vm.provision "shell", path: "#{github_url}/scripts/php.sh", args: [php_timezone, hhvm, php_version]

  # Enable MSSQL for PHP
  # config.vm.provision "shell", path: "#{github_url}/scripts/mssql.sh"

  # Provision Vim
  # config.vm.provision "shell", path: "#{github_url}/scripts/vim.sh", args: github_url

  # Provision Docker
  # config.vm.provision "shell", path: "#{github_url}/scripts/docker.sh", args: "permissions"


end
