#|
  This file is a part of goodfood project.
|#

(in-package :cl-user)
(defpackage goodfood.app
  (:use :cl)
  (:import-from :caveman.app
                :<app>))
(in-package :goodfood.app)

(cl-syntax:use-syntax :annot)

@export
(defclass <goodfood-app> (<app>) ())

@export
(defvar *app* (make-instance '<goodfood-app>))
