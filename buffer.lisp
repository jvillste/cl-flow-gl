(in-package #:flow-gl.buffer)

(defun create-buffer ()
  (gl:gen-buffers 1))

(defun bind-array-buffer (buffer)
  (gl:bind-buffer :array-buffer buffer))

(defun delete-buffer (buffer)
  (gl:delete-buffers (list buffer)))

(defun load-array-buffer (buffer data)
  (bind-array-buffer buffer)
  (let* ((length (length data))
         (gl-array (gl:alloc-gl-array :float length)))
    (dotimes (i length)
      (setf (gl:glaref gl-array i) (aref data i)))
    (gl:buffer-data :array-buffer :static-draw gl-array)
    (gl:free-gl-array gl-array)))

(defun array-buffer-from-data (data)
  (let ((buffer (create-buffer)))
    (load-array-buffer buffer data)
    buffer))
