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
