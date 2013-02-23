;;;; package.lisp

(defpackage #:flow-gl
  (:use #:cl)
  (:export :start))

(defpackage #:flow-gl.util
  (:use #:cl)
  (:export :comment))

(defpackage #:flow-gl.shader
  (:use #:cl #:flow-gl.util)
  (:export :compile-program
	   :set-float-uniform))

(defpackage #:flow-gl.buffer
  (:use #:cl #:flow-gl.util)
  (:export :create-buffer
           :bind-array-buffer
           :delete-buffer
           :load-array-buffer))

(defpackage #:flow-gl.triangle-list
  (:use #:cl #:flow-gl.util))

(defpackage #:flow-gl.window
  (:use #:cl)
  (:export :start))
