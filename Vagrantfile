# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  config.vm.hostname = "ubuntu-focal"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/focal64"

  config.vm.network :forwarded_port, guest: 80, host: 8000 # Web server
  config.vm.network :forwarded_port, guest: 3306, host: 3307 # MySQL
  config.vm.network :forwarded_port, guest: 5900, host: 5901 # X11VNC

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", '3000']
    vb.customize ["modifyvm", :id, "--cpus", "2"]   
  end

  shared_dir = "/vagrant"

  config.vm.provision :shell, path: "./scripts/setup.sh", args: "pkp ojs master", privileged: false
end
