
(cl:in-package :asdf)

(defsystem "lab7-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "PumaAction" :depends-on ("_package_PumaAction"))
    (:file "_package_PumaAction" :depends-on ("_package"))
    (:file "PumaActionFeedback" :depends-on ("_package_PumaActionFeedback"))
    (:file "_package_PumaActionFeedback" :depends-on ("_package"))
    (:file "PumaActionGoal" :depends-on ("_package_PumaActionGoal"))
    (:file "_package_PumaActionGoal" :depends-on ("_package"))
    (:file "PumaActionResult" :depends-on ("_package_PumaActionResult"))
    (:file "_package_PumaActionResult" :depends-on ("_package"))
    (:file "PumaFeedback" :depends-on ("_package_PumaFeedback"))
    (:file "_package_PumaFeedback" :depends-on ("_package"))
    (:file "PumaGoal" :depends-on ("_package_PumaGoal"))
    (:file "_package_PumaGoal" :depends-on ("_package"))
    (:file "PumaResult" :depends-on ("_package_PumaResult"))
    (:file "_package_PumaResult" :depends-on ("_package"))
  ))