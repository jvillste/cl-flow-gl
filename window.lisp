(in-package #:flow-gl.window)

(defclass window (glut:window)
  ()
  (:default-initargs :width 500 :height 500 :title "cube.lisp"
                     :mode '(:single :rgb)))

(defmethod glut:display-window :before ((w window))
  (gl:clear-color 0 0 0 0)
  (gl:shade-model :flat)

  (gl:enable :blend)
  (gl:enable :texture-2d)

  (gl:color-mask t t t t)
  (gl:blend-func :src-alpha :one-minus-src-alpha))

(defmethod glut:display ((w window))
  (gl:clear :color-buffer)
  (gl:color 1 1 1)
  (gl:load-identity) ; clear the matrix
  ;; viewing transformation
  (glu:look-at 0 0 5 0 0 0 0 1 0)
  ;; modeling transformation
  (gl:scale 1 2 1)
  (glut:wire-cube 1)
  (gl:flush))

(defmethod glut:reshape ((w window) width height)

  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:ortho 0 width 0 height -1 1)

  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:scale 1 -1 1)
  (gl:translate 0 (- height) 0))

(defmethod glut:keyboard ((w window) key x y)
  (declare (ignore x y))
  (when (eql key #\Esc)
    (glut:destroy-current-window)))

(defun start ()
  (glut:display-window (make-instance 'window)))

