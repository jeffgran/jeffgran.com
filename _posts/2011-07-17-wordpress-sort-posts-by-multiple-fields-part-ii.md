---
title: "WordPress: Sort Posts by Multiple Fields (Part II)"
author: Jeff Gran
layout: post
excerpt: "Here's a fast and easy way to sort your posts by multiple fields, using the posts_orderby filter hook and a simple function."
permalink: /262/blog/wordpress-sort-posts-by-multiple-fields-part-ii
tags: PHP Web WordPress
---
# WordPress: Sort Posts by Multiple Fields (Part II)

### The Sequel!

Because my previous post ([WordPress: Sort Posts by Multiple Fields][1]) was one of my most popular posts, and because I have realized since then that the solution it proposes is an inadequate one, I felt the need to write an update. I don’t want to be spreading bad information, and for a blog with any significant number of posts, that solution is untenable.

 [1]: /218/blog/wordpress-sort-posts-by-multiple-fields "WordPress: Sort Posts by Multiple Fields"

As a commenter pointed out, sorting by multiple fields can be accomplished using the \`posts_orderby\` filter hook, which uses MySQL directly to sort the posts, instead of getting all the posts from the database into a gigantic array, and then sorting them with php code. Here’s how to do it.

### Writing an orderby Function

You’ll need to write a function that returns a SQL fragment represented as a string, and then connect it to the filter hook. The SQL fragment is the \`ORDER BY\` segment of the SQL query that gets your posts from the database. See [the MySQL Documentation on sorting][3] for more info on this.

 [3]: http://dev.mysql.com/doc/refman/5.0/en/sorting-rows.html

Here’s an example of a custom sorting function:

~~~~ php
function order_by_multiple( $orderby) {
  return "post_date ASC, post_title DESC";
}
~~~~

The above would sort the posts by date in ascending order first, and secondarily by title in descending (reverse) order. 

### Only Sort on a certain page

You can also make this much more complex, if you want to. One important way is by using the different “[Conditional Tags][4]” WordPress provides. Here’s an example that only applies the custom sort on the home page:

 [4]: http://codex.wordpress.org/Conditional_Tags

~~~~ php
function order_by_multiple( $orderby) {
  if (!is_home()) {
    return "post_date ASC, post_title DESC";
  }
}
~~~~

### Hook up the sort function

Then, once you have your ordering function written, you just need to hook it into the WordPress code like this:

~~~~ php
add_filter("posts_orderby", "order_by_multiple");
~~~~

Make the second string argument there match your function name, of course (it doesn’t have to be the same name as mine, it can be anything). And you can have more than one function hook into the same hook. They will be executed in the same order they are added. In that case, the \`$orderby\` argument that’s coming into the function is the existing SQL fragment. So you could add to it, remove something from it, etc.

### Use Debug Query to help figure out what to return

So the question is, how do you know what to put in your SQL fragment string? If you know your SQL well, you might be able to figure it out by intuition/trial-and-error. For the rest of us, there is a very helpful WordPress Plugin called [Debug Queries][5] which will print out all of the MySQL queries that are run for every page you visit (only for logged-in admins, of course. It’s just a debugging tool for use while developing).

 [5]: http://wordpress.org/extend/plugins/debug-queries/

If you install it, it will print out many queries per page. You have to look for the one that’s querying for posts. In my testing, mine looks like this:

~~~~ sql
SELECT SQL_CALC_FOUND_ROWS wp_posts.* FROM wp_posts (...)
~~~~

The important part is the \`FROM wp_posts\`. That means you’re selecting rows from the posts table. So if you have plugins or metadata that you’re selecting on, you will see them in that query, and it may help you figure out what incantation you need to put in that \`orderby\` string.

If you need to sort by category, tag, custom meta-data, etc. as one of your sort values, you may need to alter your MySQL query even more, perhaps [using other hooks][6] (very similar to the \`posts\_orderby\` hook), such as \`posts\_join\`, \`posts_where\`, etc. Each of these modify different parts of the query.

 [6]: http://codex.wordpress.org/Custom_Queries

Beyond that, if you still need help figuring out how to get the exact set of posts in the right order, you may need to read up on MySQL in general and learn how to manipulate the queries in more detail. Good Luck!
