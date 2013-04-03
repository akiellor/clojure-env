dep 'clojure' do
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
  requires 'emacs24.managed'
  requires 'emacs24.config'
end

dep 'emacs24.config' do
  require 'fileutils'
  
  emacs_config_path = "/home/vagrant/.emacs.d/init.el"
  emacs_config_dir_path = "/home/vagrant/.emacs.d"
  user = 'vagrant'
  content = <<-EOS
(require 'package)

(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(solarized-theme clojure-mode starter-kit starter-kit-lisp starter-kit-bindings starter-kit-eshell clojure-mode clojure-test-mode nrepl))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'manoj-dark)
  EOS
  
  met? { File.file?(emacs_config_path) && Etc.getpwuid(File.stat(emacs_config_dir_path).uid).name == user && File.read(emacs_config_path) == content }
  meet {
    FileUtils.makedirs(File.dirname(emacs_config_path))
    FileUtils.chown_R(user, user, File.dirname(emacs_config_path))
    File.open(emacs_config_path, "w") {|f| f << content }
  }
end

dep 'emacs24.managed' do
  requires 'cassou ppa'
end

dep 'cassou ppa' do
  requires 'python-software-properties.managed'

  met? { File.exists?("/etc/apt/sources.list.d/cassou-emacs-precise.list") }
  meet { shell! "add-apt-repository -y ppa:cassou/emacs" }
  after { shell! "apt-get update" }
end

dep 'python-software-properties.managed' do
  installs {
    via :apt, %w{python-software-properties}
  }
  provides %w{add-apt-repository}
end

dep 'java.managed' do
  installs {
    via :apt, %w{openjdk-7-jdk openjdk-7-source}
  }
end
