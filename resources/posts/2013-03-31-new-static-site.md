---
title: New Static Site
author: Jeff Gran
tags: announcement clojure lisp emacs
---
# New Static Site

I just migrated from WordPress to a staticly-generated site, using a nifty little site generator called "[static][]" written in [clojure][].

I've really fallen in love with lisp lately, and since clojure is the hot new lisp dialect I thought I'd find an excuse to learn and use it. So here we are.

My templates are now written in clojure (hiccup), and my posts and pages are written in markdown. It's a beautiful thing, because now I can write my posts in markdown inside [emacs][]

My favorite thing about clojure so far might be [hiccup][], which is an html-generation library. It lets you write html structure with a lisp-y nested syntax.

This turns out to work perfectly. HTML is a nested tree structure with a verbose and annoying syntax, and clojure code is a nested tree structure with a simple and easily-manipulable syntax. Here's an example of some hiccup code (the "meat" part of my new page template):

~~~~ clojure
(html [:body
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
            [:li [:a {:href "/index.html"} "Front"]]]]]]])
~~~~

Anyway, this makes it so much easier to update my site (just write a new markdown file and run `lein run --rsync`) that hopefully I'll update more often when I have a thought to put down.


[static]: http://nakkaya.com/static.html
[clojure]: /tags/index.html#clojure
[emacs]: /tags/index.html#emacs
[hiccup]: https://github.com/weavejester/hiccup
