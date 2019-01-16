---
title: A Web Experiment: "Ajax Convo"
author: Jeff Gran
permalink: /239/blog/web-experiments-1-ajax-convo
tags: AJAX javascript jQuery PHP Web
---
# A Web Experiment: "Ajax Convo"

![Ajax Convo][1]

 [1]: http://jeffgran.com/img/ac.jpg "ac"

1.  I’m learning object-oriented design, design patterns, object-oriented PHP, and object-oriented JavaScript right now.

    I wanted to do some experimenting with building systems using these concepts, so I came up with the idea of doing a series of “Web Experiments” where I take an idea for some kind of web application and make a demo of it, for fun and learning.

2.  I think ajax is the future of the web. Somebody somewhere wrote “full page refreshes are so last year”, or something to that effect. I sometimes find myself clicking a link or a tab somewhere out there on the web, mentally crossing my fingers in hopes that it won’t send me to a new page.

    I think more and more people are going to expect slicker interfaces in web sites and web applications, and ajax is the way to get that accomplished.

3.  I really like the comment/reply interface on Facebook. There’s a series of boxes, each with a comment, and the last box is minimized and says “Write a comment…”. When you click on it, it expands to look exactly like the other comments, with your picture there, just like it will look once it’s posted.

    You type your brilliant quip, and when you click the button, the comment “melts” right into the page, and the next would-be comment appears below.. I think it’s lovely.

With these three things in mind, I started building my own little “comment thread” app. 

### Features:

*   Add, edit, and remove comments from the “thread”.
*   No page refreshes – all done with ajax (jQuery)
*   Comments are stored in a tab-separated text file.
*   Shift-enter for a line break within a comment.

I’ve also built a class structure that I believe will help me expand the project going forward. 

### Planned additions/expansions:

*   MySQL Database support (will be able to switch between text file and MySQL with a single setting)
*   Rewrite the JavaScript without using jQuery just for fun and practice, and to prove that I can.
*   Multiple “threads” of comments
*   Only load the latest 10 comments or so, and load more twitter-style.
*   More to each message, like time/date of post, “last edited at…”, etc.
*   Maybe a simple user system. I loathe to make people “sign up” for things though.

If you’re interested, you can download the files [here][2].

 [2]: http://jeffgran.com/stuff/ac.zip "Ajax Convo Zip File"
