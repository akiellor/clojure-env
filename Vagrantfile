Vagrant::Config.run do |config|
  config.vm.box = "precise32"

  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.provision :shell, :inline => "/tmp/bootstrap/go"
  config.vm.share_folder "bootstrap", "/tmp/bootstrap", "bootstrap"
end
