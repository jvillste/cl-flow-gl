;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;; shader-vao.lisp --- Example usage of vertex and fragment shaders,
;;; vertex buffer objects, and vertex array objects
(in-package #:flow-gl.shader)

(define-condition compilation-error (error)
  ((text :initarg :text :reader text)))

(defun compile-shader (shader source)
  (gl:shader-source shader source)
  (gl:compile-shader shader)
  (when (> (gl:get-shader shader :info-log-length)
           0)
    (error 'compilation-error :text (gl:get-shader-info-log shader))))

(defun create-program (vertex-shader fragment-shader)
  (let ((program (gl:create-program)))
    (gl:attach-shader program vertex-shader)
    (gl:attach-shader program fragment-shader)
    (gl:link-program program)
    (gl:validate-program program)
    (when (> (gl:get-program program :info-log-length)
             0)
      (error 'compilation-error :text (gl:get-program-info-log program)))

    program))

(defun compile-program (vertex-shader-source fragment-shader-source)
  (let ((vertex-shader (gl:create-shader :vertex-shader))
        (fragment-shader (gl:create-shader :fragment-shader)))
    (compile-shader vertex-shader vertex-shader-source)
    (compile-shader fragment-shader fragment-shader-source)

    (create-program vertex-shader
                    fragment-shader)))

(defun set-float-uniform (program name &rest values)
      (apply #'gl:uniformf (gl:get-uniform-location program
                                                    name)
             values))

