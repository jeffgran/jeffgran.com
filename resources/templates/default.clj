[:html
 [:head
  [:meta {:charset "utf-8"}]
  [:meta
   {:http-equiv "content-type", :content "text/html; charset=UTF-8"}]
  [:meta {:name "description", :content (:description metadata)}]
  [:meta {:name "keywords", :content (:tags metadata)}]
  ;; mobile-spefic meta
  [:meta {:name "viewport", :content "width=device-width, initial-scale=1, maximum-scale=1"}]

  ;; title
  (if (contains? metadata :title)
    [:title (:title metadata)])
  
  ;; fonts and css
  [:link {:rel "stylesheet", :type "text/css", :href "http://fonts.googleapis.com/css?family=Oxygen"}]
  [:link {:rel "stylesheet", :type "text/css", :href "http://fonts.googleapis.com/css?family=Julius+Sans+One"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/base.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/skeleton.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/layout.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/site.css"}]

  ;; favicon
  [:link {:rel "shortcut icon", :href "images/favicon.ico"}]
  

  "<!--[if lt IE 9]>"
  [:script {:src "http://html5shim.googlecode.com/svn/trunk/html5.js"}]
  "<![endif]-->"
  
  ] ; /head
 
 [:body

  [:div#content.container
   [:div.sixteen.columns
    content]]

  
  ]]
