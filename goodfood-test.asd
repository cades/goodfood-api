#|
  This file is a part of goodfood project.
|#

(in-package :cl-user)
(defpackage goodfood-test-asd
  (:use :cl :asdf))
(in-package :goodfood-test-asd)

(defsystem goodfood-test
  :author ""
  :license ""
  :depends-on (:goodfood
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "goodfood"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
