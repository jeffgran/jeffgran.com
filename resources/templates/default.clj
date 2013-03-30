[:html
 [:head
  (if (contains? metadata :title)
    [:title (:title metadata)])
  ] ; /head
 
 [:body
  
  [:div {:id "content"}
   content]

  (static.jg/my-content)

  
  ]]
