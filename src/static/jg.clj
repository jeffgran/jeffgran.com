(ns static.jg
  (:use [hiccup core page util]))

(defn my-content []
  [:p "Hello this is my test content."])


(defn tag-link [tag]
  (html [:li [:a.tag-link {:href (str "/tags/index.html#" tag)} tag]]))


(defn jg-meta [metadata]
  [:div#metadata
   ;;(str metadata)
   (when (contains? metadata :publish_date)
     (html [:h5.meta-heading "Published:"]
           [:p.meta-value (:publish_date metadata)]
           [:div.clear]))
   (when (contains? metadata :tags)
     (html      
      [:h5.meta-heading "Tags:"]
      [:ul.tag-list (html (map (fn [tag]
                                 (tag-link tag))
                               (.split (:tags metadata) " ")))]
      [:div.clear]))])
