dep 'clojure' do
  requires 'java.managed'
  requires 'clojure.managed'
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
