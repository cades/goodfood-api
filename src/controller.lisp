#|
  This file is a part of goodfood project.
|#

(in-package :cl-user)
(defpackage goodfood.controller
  (:use :cl
        :caveman
	:st-json
        :goodfood.app)
  (:import-from :goodfood.view.emb
                :render))
(in-package :goodfood.controller)

(cl-syntax:use-syntax :annot)

@url GET "/"
(defun index (params)
  @ignore params
  (render "index.html"))

(defun make-utf8-http-stream (url)
  (let ((stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    stream))

;; mongodb Simple REST Interface (read only)
(defparameter *mongodb-server-url* "http://localhost:28017/opendata/goodfood/")

(defun map-date-to-doc (date)
  "對應日期到'最近的'節氣mongodb文件."
  (let* ((raw-data (read-json (make-utf8-http-stream *mongodb-server-url*)))
	 (mongo-docs (getjso "rows" raw-data))
	 (target-date (net.telent.date:parse-time date))
	 (doc (cdr (reduce #'(lambda (o1 o2) (if (< (abs (- target-date (car o1))) (abs (- target-date (car o2)))) o1 o2))
			   (mapcar #'(lambda (obj)
				       (cons
					(/ (+ (net.telent.date:parse-time (getjso "begin" obj))
					      (net.telent.date:parse-time (getjso "end"   obj))) 2)
					obj))
				   mongo-docs)))))
    doc))

(defun map-date-to-food (date)
  "對應日期到'最近的'節氣, 回傳節氣名稱、時間與當季食材."
  (let ((doc (map-date-to-doc date)))
    (write-json-to-string (jso "name"  (getjso "name" doc)
			       "begin" (getjso "begin" doc)
			       "end"   (getjso "end" doc)
			       "food"  (getjso "food" doc)))))

(defun map-date-to-wallpaper (date size)
  (let ((doc (map-date-to-doc date)))
    (getjso size (getjso "wallpaper" doc))))
  
@url GET "/food-of-season/today"
(defun food-of-season-of-today (params)
  @ignore params
  `(200
    (:content-type "application/json; charset=utf-8")
    (,(let* ((timestamp (multiple-value-list (get-decoded-time)))
	    (date (format nil "~A-~A" (fifth timestamp) (fourth timestamp))))
       (map-date-to-food date)))))

@url GET "/food-of-season/:date"
(defun food-of-season-of-date (params)
  `(200
    (:content-type "application/json; charset=utf-8")
    (,(map-date-to-food (getf params :date)))))

@url GET "/wallpaper/:size/:date"
(defun wallpaper (params)
  (redirect-to (map-date-to-wallpaper (getf params :date) (getf params :size))))
