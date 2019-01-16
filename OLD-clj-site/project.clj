(defproject static "1.1.0-SNAPSHOT"
  :description "Simple static site generator."
  :dependencies [[org.clojure/clojure "1.4.0"]
                 [org.clojure/tools.cli "0.2.2"]
                 [org.clojure/tools.logging "0.2.6"]
                 [cssgen "0.3.0-SNAPSHOT"]
                 [hiccup "1.0.3"]
                 [org.pegdown/pegdown "1.2.0"]
                 [org.clojars.amit/commons-io "1.4.0"]
                 [ring/ring-core "1.1.8"]
                 [ring/ring-jetty-adapter "1.1.8"]
                 [uochan/watchtower "0.1.4"]]
  :main static.core
  :jar-name "static.jar"
  :uberjar-name "static-app.jar")
