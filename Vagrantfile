# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#-------------------------------------------------------------------------------
# 【注意事項】
# - shared folderのmountに失敗する場合、VirtualboxGuestAdditionのバージョンが
#   ホストとゲストでずれている可能性があります。
#   その場合、プロジェクトルートで以下のコマンドを手動で実行してください。
#   > vagrant plugin install vagrant-vbguest
#   > vagrant vbguest
#-------------------------------------------------------------------------------
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/centos-6.7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  #-----------------------------------------------------------------------------
  # vbguestプラグイン対応
  # - vbguestプラグインをインストールしている場合、それが原因で vagrant up に失敗する
  #   場合があるため、プラグインによる自動更新を行わないように設定します。
  #-----------------------------------------------------------------------------
  if Object.const_defined? 'VagrantVbguest'
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.200"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-
  config.vm.synced_folder "./", "/var/www/ansible-examples", mount_options:["dmode=777", "fmode=777"]
  config.ssh.insert_key = false

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
   config.vm.provider "virtualbox" do |vb|
      # setup memory size
      vb.memory = "1024"
      # for Windows Development
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/var/www/ansible-examples", "1"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/var/www/ansible-examples/*", "1"]
    end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL
  Encoding.default_external = 'UTF-8'
#  config.vm.provision "shell", path: "wordpress-nginx/provision-ansible.sh"
#  config.vm.provision "shell", path: "docker/provision-ansible.sh"
  config.vm.provision "shell", path: "laravel-deploy/deploy-ansible.sh"
end
