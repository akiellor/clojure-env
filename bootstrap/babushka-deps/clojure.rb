dep 'clojure' do
  requires 'java.managed'
  requires 'clojure.managed'
  requires 'emacs24'
end

dep 'emacs24' do
  requires 'emacs24.managed'
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

dep 'clojure.managed' do
  installs {
    via :apt, %w{clojure}
  }
end

dep 'java.managed' do
  installs {
    via :apt, %w{openjdk-7-jdk openjdk-7-source}
  }
end
