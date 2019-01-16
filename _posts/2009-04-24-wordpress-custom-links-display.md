---
title: 'WordPress: Custom Links Display'
author: Jeff Gran
layout: post
categories:
  - Blog
tags: PHP Web WordPress
---
# WordPress: Custom Links Display

I’ve been working with WordPress for a couple of days now, and I’m thoroughly impressed by its elegant design. I’ve always been a fan of modular, extensible, customizable systems, and WordPress does not disappoint. The great thing about the architecture they’ve built is that if one level of control can’t do what you need, there is always another successive level to delve into.

My point will be made more easily with an example:  I wanted to show the links on my “Links” page in boxes, with linked title and images, and a short description, all controlled by CSS classes.

WordPress offers a “template tag” (that is, PHP function) for theme creators to display the list of links added via the admin panel.  You can put it anywhere in your templates (for example, in the sidebar) and it will automatically keep the list up-to-date:

~~~~ php
wp_list_bookmarks();
~~~~

That function generates an unordered list of link categories, with sub-lists of each link, complete with CSS styles assigned so that you can add a custom style.  But, say you (like me) don’t want the categories, just the links please.  And can I have it show the images associated with the links as well?

To this end, the WordPress developers have included a large range of optional arguments for the function above, so you can include or exclude categories, decide whether to format the list as an unordered list () or other custom HTML tag, whether to show the images and descriptions, etc:

~~~~ php
wp_list_bookmarks(
   'categorize=0&title_li=&show_images=1&show_description=1');
~~~~

Pretty good, but what if I want even more control (I usually do ;) )?  The next-deepest level of under-the-hood-ness allows you to get the list of links, store it in an array, and then loop through the array using a simple PHP foreach loop that outputs the link data in whatever custom format you need.  It’s easier than it sounds.  Here’s the final code I used for my links page:


~~~~ php
<?php
$myLinks = get_bookmarks();
foreach($myLinks as $myLink) { ?>
   <div class="linkBox">
      <a href="<?php echo($myLink->link_url); ?>">
         <img src="<?php echo($myLink->link_image); ?>" />
      </a>
      <h3>
         <a href="<?php echo($myLink->link_url); ?>">
            <?php echo($myLink->link_name); ?>
         </a>
      </h3>
      <p><?php echo($myLink->link_description); ?></p>
   </div>
<?php } ?>
~~~~
