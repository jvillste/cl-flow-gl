;;;; flow-gl.asd

(asdf:defsystem #:flow-gl
  :serial t
  :description "Describe flow-gl here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:cl-opengl
               #:cl-glut
               #:cl-glu
	       #:fset)
  :components ((:file "package")
	       (:file "util")
               (:file "flow-gl")
	       (:file "shader")
	       (:file "buffer")
	       (:file "triangle-list")
	       (:file "window")))

; (asdf:load-system :flow-gl)
