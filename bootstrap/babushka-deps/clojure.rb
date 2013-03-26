dep 'clojure' do
  requires 'java.managed'
  requires 'emacs24.managed'
  requires 'leiningen'
end

dep 'leiningen' do
  met? { File.file?("/bin/lein") }
  meet {
    shell "curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > /bin/lein && chmod 755 /bin/lein"
  }
end

dep 'emacs24.managed' do
  requires 'cassou ppa'
end

dep 'cassou ppa' do
  requires 'python-software-properties.managed'

  met? { File.exists?("/etc/apt/sources.list.d/cassou-emacs-precise.list") }
  meet { shell "add-apt-repository -y ppa:cassou/emacs" }
  after { shell "apt-get update" }
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
