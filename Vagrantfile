Vagrant::Config.run do |config|
  config.vm.box = "precise32"

  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.provision :shell, :inline => "cd /vagrant/bootstrap && ./go"
end
