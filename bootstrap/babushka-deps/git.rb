dep "git.config" do
  file = "/home/vagrant/.gitconfig"
  config = File.expand_path("git.config", File.join(File.dirname(__FILE__), "files")).p.read

  met? { file.p.file? && file.p.read == config }
  meet { file.p.open("w") {|f| f << config } }
end
