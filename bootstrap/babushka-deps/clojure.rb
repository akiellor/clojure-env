dep 'clojure' do
  requires 'java.managed'
  requires 'emacs24.managed'
  requires 'leiningen'
end

dep 'leiningen' do
  lein_bin = "/bin/lein"

  met? { lein_bin.p.exists? }
  meet {
    shell "curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > #{lein_bin} && chmod 755 #{lein_bin}"
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
