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

dep 'emacs24.config', :template => "file-deps:file" do
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
