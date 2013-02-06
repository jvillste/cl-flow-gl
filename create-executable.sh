sbcl --eval "(load \"flow-gl.asd\")" --eval "(asdf:load-system :flow-gl)" --eval "(save-lisp-and-die \"flow-gl\" :executable t :toplevel #'flow-gl:start :compression t)"
