(in-package #:serapeum.tests)

(def-suite serapeum)
(in-suite serapeum)

(defmacro test (name &body body)
  `(5am:test ,name
     (locally
         (declare #+sbcl (sb-ext:muffle-conditions
                          style-warning
                          sb-ext:compiler-note))
       ,@body)))

(defun run-tests ()
  (5am:run! 'serapeum))

(defun run-tests/quiet ()
  (handler-bind ((warning #'muffle-warning))
    (run-tests)))

(defun debug-test (test)
  (let ((5am:*on-error* :debug)
        (5am:*on-failure* :debug))
    (run! test)))

(defun a-fixnum ()
  (lambda ()
    (random-in-range most-negative-fixnum most-positive-fixnum)))

(defun an-iota (n)
  (lambda ()
    (range n)))

(defun a-list-of (len fn)
  (lambda ()
    (map-into (make-list len) fn)))

(defun eval* (form)
  "Variant of eval forcing macroexpansion."
  (funcall (compile nil (eval `(lambda () ,form)))))
