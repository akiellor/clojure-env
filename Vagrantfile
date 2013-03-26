Vagrant::Config.run do |config|
  config.vm.box = "precise32"

  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.share_folder "bootstrap", "/tmp/bootstrap", "bootstrap"
  config.vm.provision :shell, :inline => "cd /tmp/bootstrap && ./go"
end
