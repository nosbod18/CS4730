; Auto-generated. Do not edit!


(cl:in-package lab7-msg)


;//! \htmlinclude PumaFeedback.msg.html

(cl:defclass <PumaFeedback> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass PumaFeedback (<PumaFeedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PumaFeedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PumaFeedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lab7-msg:<PumaFeedback> is deprecated: use lab7-msg:PumaFeedback instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PumaFeedback>) ostream)
  "Serializes a message object of type '<PumaFeedback>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PumaFeedback>) istream)
  "Deserializes a message object of type '<PumaFeedback>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PumaFeedback>)))
  "Returns string type for a message object of type '<PumaFeedback>"
  "lab7/PumaFeedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PumaFeedback)))
  "Returns string type for a message object of type 'PumaFeedback"
  "lab7/PumaFeedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PumaFeedback>)))
  "Returns md5sum for a message object of type '<PumaFeedback>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PumaFeedback)))
  "Returns md5sum for a message object of type 'PumaFeedback"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PumaFeedback>)))
  "Returns full string definition for message of type '<PumaFeedback>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PumaFeedback)))
  "Returns full string definition for message of type 'PumaFeedback"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PumaFeedback>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PumaFeedback>))
  "Converts a ROS message object to a list"
  (cl:list 'PumaFeedback
))
