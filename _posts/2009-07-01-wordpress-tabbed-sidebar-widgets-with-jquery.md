---
title: "WordPress: Tabbed Sidebar Widgets with jQuery"
author: Jeff Gran
layout: post
excerpt: "Tabs are a great way to show more information in less space, assuming the initially-hidden tabs are non-essential information.  Recently a client asked me to put a few Wordpress widgets into a single tabbed container in the sidebar.  Here's how I did it."
permalink: /180/blog/wordpress-tabbed-sidebar-widgets-with-jquery
tags: jQuery WordPress
---
# WordPress: Tabbed Sidebar Widgets with jQuery

Tabs are a great way to show more information in less space, assuming the initially-hidden tabs are non-essential information.  Recently a client asked me to put a few WordPress widgets into a single tabbed container in the sidebar.  Here’s how I did it.

### The Problem

There’s no reason to re-invent the wheel, and there are already several tabs implementations written as jQuery plugins, including the [jQuery UI tabs widget][1]. The problem with these is that most (if not all) of them require the markup to be set up in a different way than we have available with our WordPress-outputted sidebar markup.

 [1]: http://jqueryui.com/demos/tabs/ "jQuery UI Tabs"

To illustrate, WordPress by default outputs the sidebar with markup that is structured something like this:

~~~~ html
<div id="sidebar-1">
  <ul class="sidebar-list">
    <li id="widget-1" class="widget widget-class-1">
      <h2>Widget 1 Title</h2>
      <p>...content...</p>
    </li>
    <li id="widget-2" class="widget widget-class-2">
      <h2>Widget 2 Title</h2>
      <p>...content2...</p>
    </li>
  </ul>
</div>
~~~~

The various jQuery tabs plugins all require the markup to be strutured like this (notice the titles moved to the additional list at the top, with anchor tags corresponding to the ids of the respective widgets:

~~~~ html
<div id="sidebar-1">
  <ul>
    <li><a href="#widget-1">Widget 1 Title</a></li>
    <li><a href="#widget-2">Widget 2 Title</a></li>
  </ul>
  <ul class="sidebar-list">
    <li id="widget-1" class="widget widget-class-1">
      <p>...content...</p>
    </li>
    <li id="widget-2" class="widget widget-class-2">
      <p>...content2...</p>
    </li>
  </ul>
</div>      
~~~~

### The Solution

While it would be possible to alter the PHP code to output the list above the widgets (although, I looked into this solution and was not able to find a hook that would allow it without altering the core), we can just use some custom jQuery to dynamically add the list before invoking the tabs plugin.

This method also has the advantage that it makes our tabs more unobtrusive. If javascript is disabled, the page will look exactly as it would with the standard sidebar widgets, but if javascript is available, we’ll fix the markup and add the tabs all at once with our jQuery code.

### The Code

~~~~ javascript
$(document).ready(function() {
   // first, we select the sidebar
   $('#sidebar-1 .sidebar-list').each(function() {
      // each child of the sidebar element will be a widget,
      // and will become a tab
      var widgets = $(this).children();
 
      // we'll build the list of titles, starting with the opening tag
      var titleList = '<ul>';
 
      //for each widget in the sidebar:
      widgets.each(function() {
 
         // save the title of the widget
         var widgetTitle = $(this).children('h2').text();
         // then hide it since it will be displayed in the tab
         $(this).children('h2').hide();
 
         // create a new list item for the tab, linking to
         // this widget's id
         var listItem =
           '<li><a href="#'+
           $(this).attr('id')+
           '">'+
           widgetTitle+'</a></li>';
         // add the list item to the list we're building
         titleList += listItem;
      });
      // close the list now that we're done going through each widget
      titleList += '</ul>';
 
      // add the title list to the beginning of the sidebar
      $(this).before(titleList);
   });
 
   // apply the tabs plugin
   $('#sidebar-1').tabs();
});
~~~~

### Explanation

The comments in the code should make the solution pretty self-explanatory.  This will take all the widgets in the selected sidebar and create tabs for them.

There are some things you’ll have to be careful about if you use this code.

First, you’ll have to change the selection for the sidebar div (line 3 above, as well as in the second-to-last line) to match yours.  This assumes you *have* your sidebar list wrapped in a div (required by the tabs plugin), so if you don’t, you will need to add that, either in the theme itself or with jQuery( using .wrap() ).

Also, in the two places you see 'h2', this is assuming that the titles of the widgets are in \<h2\> tags.  You may need to select a different tag if your theme displays the widget titles differently.

Also note that this will create tabs for *all* the widgets in the sidebar.  Making it only apply to specific widgets is possible, but a bit more complicated.

Luckily, with WordPress 2.8, the sidebars/widgets interface is much improved.  One solution would be to create multiple ‘sidebars’ that stacked on top of each other in the sidebar area of your theme, and apply the above tab-ifying code to one or more of them individually.
