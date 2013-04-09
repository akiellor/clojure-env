dep 'clojure' do
  requires 'git.config'
  requires 'java.managed'
  requires 'emacs24'
  requires 'leiningen'
end

dep 'leiningen' do
  lein_bin = "/bin/lein"

  met? { lein_bin.p.exists? }
  meet {
    shell! "curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > #{lein_bin} && chmod 755 #{lein_bin}"
  }
end

dep 'emacs24' do
  requires 'emacs-deps:emacs24.managed'
  requires 'emacs24.config'
end

meta "file" do
  accepts_value_for :source
  accepts_value_for :target
  accepts_value_for :owner, "root"
  accepts_value_for :group, "root"
  accepts_value_for :permissions, "644"

  template {
    def source_path
      dependency.load_path.parent / source
    end

    met? { target.p.file? && target.p.owner == owner && target.p.group == group && File.stat(target).mode.to_s(8)[3..5] == permissions && source_path.read == target.p.read } 
    meet {
      target.p.open("w+") do |f|
        f << source_path.read
      end
      shell! "chown #{owner}:#{group} #{target}"
      shell! "chmod #{permissions} #{target}"
    }
  }
end

dep 'emacs24.config', :template => "file" do
  owner "vagrant"
  group "vagrant"
  
  user_home = Etc.getpwnam(owner).dir

  source ".emacs.d/init.el"
  target user_home.p / ".emacs.d" / "init.el"
end

dep 'java.managed' do
  installs {
    via :apt, %w{openjdk-7-jdk openjdk-7-source}
  }
end
