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
  [:link {:rel "stylesheet", :type "text/css", :href "http://fonts.googleapis.com/css?family=Lilita+One"}]
  [:link {:rel "stylesheet", :type "text/css", :href "http://fonts.googleapis.com/css?family=Julius+Sans+One"}]
  [:link {:rel "stylesheet", :type "text/css", :href "http://fonts.googleapis.com/css?family=Inconsolata"}]
  
  [:link {:rel "stylesheet", :type "text/css", :href "/base.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/skeleton.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/layout.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/site.css"}]
  [:link {:rel "stylesheet", :type "text/css", :href "/highlight.js/styles/solarized_dark.css"}]

  
  ;; favicon
  [:link {:rel "shortcut icon", :href "images/favicon.ico"}]
  
  ;; modernize old IEs
  "<!--[if lt IE 9]>"
  [:script {:src "http://html5shim.googlecode.com/svn/trunk/html5.js"}]
  "<![endif]-->"

  ;; javascripts
  [:script {:src "/highlight.js/highlight.pack.js"}]
  [:script {:src "/highlight.js/clojure.js"}]
  [:script {:src "/site.js"}]
  
  ] ; /head
 
 [:body

  [:div#content.container
   [:div.row
    [:div.twelve.columns.alpha
     content]
    [:div#jeffgran.four.columns.omega
     [:span#jeff "Jeff"]
     [:span#gran "Gran"]
     [:div.clear]
     (jg-meta metadata)]]

   [:div.row
    [:div#footer.sixteen.columns
     [:ul
      [:li [:a
            {:href "http://github.com/jeffgran/jeffgran.com"}
            "Source"]]
      [:li [:a {:href "/tags/index.html"} "By Tag"]]
      [:li [:a {:href "/archive.html"} "By Date"]]
      [:li [:a {:href "/index.html"} "Front"]]
      ]
     ]]]

  
  
  ]] ; /body/html
