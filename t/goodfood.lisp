#|
  This file is a part of goodfood project.
|#

(in-package :cl-user)
(defpackage goodfood-test
  (:use :cl
        :goodfood
        :cl-test-more))
(in-package :goodfood-test)

(plan nil)

;; make sure the app stopped
(goodfood:stop)
(goodfood:start)

;; blah blah blah.

(goodfood:stop)

(finalize)
