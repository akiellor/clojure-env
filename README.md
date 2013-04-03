clojure-env
===========

A simple project to get the most basic clojure environment. It includes:

* ubuntu
* emacs24
  * nrepl
  * clojure-mode
* lein
* java7

Getting Started
---------------

1. Get [Vagrant](http://www.vagrantup.com/)
2. $ vagrant up
3. $ vagrant ssh

Terminal.app (OSX)
------------------
Terminal.app (OSX) can behave strangly with ParEdit's C+Right and C+Left, this is because the Terminal.app/OS can be stealing these key bindings.

iTerm2
------
Running emacs in iTerm2, M+(any char) is by default interpreted as a unicode character. To fix this, go into Preferences->Profiles->Keys and set the option key of your choice to 'Esc+'
