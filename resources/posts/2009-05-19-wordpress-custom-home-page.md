---
title: WordPress: Using a custom home page
author: Jeff Gran
excerpt: |
  WordPress hs a simple checkbox in the Admin->Settings panel that lets you set a certain file to be the "static" home page instead of the default listing of the latest posts.

  I'm going to show you how (and why) I did NOT use that feature to create my customized home page.
permalink: /139/blog/wordpress-custom-home-page
tags: PHP Web WordPress
---
# WordPress: Using a custom home page

WordPress hs a simple checkbox in the Admin->Settings panel that lets you set a certain file to be the “static” home page instead of the default listing of the latest posts.

I’m going to show you how (and why) I did NOT use that feature to create my customized home page.

Here’s what I wanted:

1.  A unique page for the home page, including a few of the latest posts (displayed differently than on the main blog page)
2.  The main blog page to be located at “url.com/blog”, showing the default latest posts (assuming permalinks are turned on)
3.  All other dynamic archive pages shown by month, tag, category, etc., should be shown using the same template as the main blog page, without creating any duplicate files

Here’s how I did it:

### home.php

Instead of using the admin interface to designate a specific file for your home page, you can use WordPress’s built-in [template hierarchy][1].  This method has the advantage that if you’re building this theme for the public, it will automatically behave how you want it to, instead of having to instruct the user to alter their settings.

 [1]: http://codex.wordpress.org/Template_Hierarchy "Template Hierarchy"

To do this simply design your home page’s php/html/css, and name it home.php.  That’s it –  “home.php” takes precedence over “index.php”.

### Custom loop

WordPress shows blog posts in what they call “The Loop”.  The Loop works by doing the following:

1.  The query — gets a set of posts based on what page we’re viewing.  Usually this is automatic, using the URL (e.g. `?p=138` or `/category/news`).
2.  `if(have_posts()):` — just like it looks, it makes sure the query got at least one post.
3.  `while(have_posts()):` — keep doing the loop until we don’t have any more posts.
4.  `the_post();` — this basically “loads up” the current post in the loop so that all the [template tags][2] associated with the post will reference this specific post from this specific query.
5.  Then comes the markup output for each post.
6.  `endwhile; endif;` — the end of the loop.

 [2]: http://codex.wordpress.org/Template_Tags "Template Tags"

So, in order to customize the Loop, there are two main things we can do.  One is to make a unique query, and the other is to create a unique layout structure inside the loop.

For my home page, I wanted only the 2 most recent posts rather than the number set in the admin panel that would be used for the main blog page.  I added a simple counter and put this code in the appropriate spot in home.php:

~~~~ php
$i = 0;
if(have_posts()) : while(have_posts() && $i<2) : the_post();
   // html output, template tags, etc go here
   $i++;
endwhile; endif;
~~~~

### index.php

In the aforementioned template hierarchy, index.php is the default template for all blog pages, and in the absence of home.php it would be the home page as well.  So I used index.php to put my main, default loop.  But how do we get index.php to show up at `url.com/blog`?

This is the part that I have never seen anywhere else, and what prompted me to write this post.  What I did was use index.php for its special status in the template hierarchy, and ALSO used the same file as a Page Template.  To use index.php as a template, just add the magic keyword/comment at the top, like this:

~~~~ php
<?php /*
Template Name: blog
 */
~~~~

Now, create a blank Page in the admin panel titled Blog, and assign the "blog" page template to it.  The title will still be used to display the title on the page, and assigning the "blog"" template to it makes it use index.php as the page template.


### Custom query

So now the url for the blog is right, but it's displaying the blank page created in the admin instead of the default loop of latest blog posts.  To remedy that, we put a conditional test at the top, and if this is the blog page, we "reset" the query so that it contains all the posts.

~~~~ php
if(is_page('blog')) {
   query_posts("");
}
~~~~

The "query_posts" function creates the query, as mentioned above.  Passing an empty string as the argument makes sure we get all the posts.  We put this above the start of the Loop, to override the automatic query that is just returning the one "post", in this case being the blank Blog page.

### Fixing the pagination

There's one other quirky problem we have to deal with now.  The flaw is in the empty query.  It works, but when you get to multiple pages worth of posts, the paging will not work right.  When we click the "next page" or "page 2" link, the page number we're going gets passed to the database as part of the query.  When we override the query with a blank one, we also override the page information, so we always end up on page 1.  To fix this, we have to find add a little test to find out the proper page, and add that in to our custom query.  After adding the paging fix, our custom query looks like this:

~~~~ php
if(is_page('blog')) {
   if (get_query_var('paged'))
      $paged = get_query_var('paged');
   else $paged = 1;
   query_posts("paged=$paged");
}
~~~~

`get_query_var('paged')` gets the paging information from the original query that we're about to override.  If it's there, we use it, and if not, we assume we're on page one.  Now you can write a spiffy Loop below this and it will be used for all blog post listings, including the default one at "/blog".

I hope this was helpful to someone!
