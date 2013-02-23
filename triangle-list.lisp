(in-package #:flow-gl.triangle-list)


(defparameter vertex-shader-source "
#version 120

attribute vec2 vertex_coordinate_attribute;
attribute vec4 vertex_color_attribute;

varying vec4 color;

void main() {
    gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * vec4(vertex_coordinate_attribute[0], vertex_coordinate_attribute[1], 0.0, 1.0);
    color = vertex_color_attribute;
}

")

(defparameter fragment-shader-source "
#version 120

varying vec4 color;

void main() {
    gl_FragColor = color;
}
")

(defparameter program nil)

(defun compile-program ()
  (when (not program)
    (setf program (flow-gl.shader:compile-program vertex-shader-source fragment-shader-source))))

(defun create (mode coordinates colors])
  (compile-program)
  (fset:map (:mode mode)
            (:shader-program shader-program)
            (:vertex-coordinate-attribute-index (gl:get-attrib-location shader-program "vertex_coordinate_attribute"))
            (:vertex-color-attribute-index (gl:get-attrib-location shader-program "vertex_color_attribute"))
            (:vertex-coordinate-buffer (flow-gl.buffer:array-buffer-from-data coordinates))
            (:vertex-color-buffer (flow-gl.buffer:array-buffer-from-data colors))))

(defun delete (triangle-list)
  (flow-gl.buffer:delete-buffer (fset:lookup triangle-list :vertex-coordinate-buffer))
  (flow-gl.buffer:delete-buffer (fset:lookup triangle-list :vertex-color-buffer))
  (gl:delete-program (fset:lookup triangle-list :shader-program)))

(defun render (triangle-list)
  (gl:use-program program)

  (flow-gl.buffer:bind-array-buffer (fset:lookup triangle-list :vertex-coordinate-buffer))
  (gl:enable-vertex-attrib-array (fset:lookup triangle-list :vertex-coordinate-attribute-index))
  (gl:vertex-attrib-pointer (fset:lookup triangle-list :vertex-coordinate-attribute-index)
                            2
                            :float
                            nil
                            0
                            (cffi:null-pointer))

  (flow-gl.buffer:bind-array-buffer (fset:lookup triangle-list :vertex-color-buffer))
  (gl:enable-vertex-attrib-array (fset:lookup triangle-list :vertex-color-attribute-index))
  (gl:vertex-attrib-pointer (fset:lookup triangle-list :vertex-color-attribute-index)
                            4
                            :float
                            nil
                            0
                            (cffi:null-pointer))

  (case (fset:lookup triangle-list :mode)
    :triangles (GL11/glDrawArrays GL11/GL_TRIANGLES 0 (* 3 (:number-of-triangles triangle-list)))
    :triangle-strip (GL11/glDrawArrays GL11/GL_TRIANGLE_STRIP 0 (+ 2 (:number-of-triangles triangle-list)))
    :triangle-fan (GL11/glDrawArrays GL11/GL_TRIANGLE_FAN 0 (:number-of-triangles triangle-list))))

