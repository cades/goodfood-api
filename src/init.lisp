(swank:create-server :port 4005 :style :spawn :dont-close t)
(load "../goodfood.asd")
(ql:quickload :goodfood)
(goodfood:start)
