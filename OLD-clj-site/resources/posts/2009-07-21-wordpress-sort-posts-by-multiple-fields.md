---
title: WordPress: Sort Posts by Multiple Fields
author: Jeff Gran
permalink: /218/blog/wordpress-sort-posts-by-multiple-fields
tags: PHP WordPress
---
# WordPress: Sort Posts by Multiple Fields

### UPDATE: I have written a new post about how to better accomplish this task: [WordPress: Sort Posts by Multiple Fields (Part II)][1]

 [1]: http://jeffgran.com/262/blog/wordpress-sort-posts-by-multiple-fields-part-ii

Please see the above link for a much more efficient way to sort by multiple fields. This page is left for historical and educational purposes.

I was recently creating a star-rating system for a client, and we were sorting the reviews (or “posts”) by the number of stars. The problem that came up was that with a 5 star system, and increments of half-stars, you will necessarily end up with many of the ratings being equal. We wanted to be able to control the exact order the reviews were shown in the case of a tie. Here’s how I did it.

### Adding a "Priority" Custom Field

The first step was to add a custom field called “priority”, which would act as the tie-breaker.  Basically, if two posts have the same star rating, we’ll check the priority and see which one is higher, and that one will be displayed first.  I was using the [Flutter plugin][2], so adding another custom field was as simple as clicking a few buttons in the admin panel.

 [2]: http://flutter.freshout.us/ "Flutter WordPress Plugin Homepage"

### Custom Query

Sorting by a single field is relatively easy.  You would create a custom query for the posts by using something like this (to sort alphabetically):

~~~~ php
query_posts("orderby=title&order=ASC");
~~~~

Using Flutter’s syntax for sorting by its custom fields, we’d use:

~~~~ php
query_posts("customorderby=x_stars-overall-rating&order=DESC");
~~~~

### Refining the Order with usort()

But you can’t sort by more than one field using the above methods.  That’s where usort comes in.  PHP has [a function called usort()][3] which sorts an array based on a custom function which “compares” the two array items in any way you like.  So all we need to do is run our array of posts through a function which does the more complex comparison using both the “stars” field and then the “priority” field for tie-breakers.

 [3]: http://us2.php.net/manual/en/function.usort.php "PHP Manual: usort"

First, we insert this in the category listing page (or whichever page you’re working on) to run the custom sort function:

~~~~ php
usort($wp_query->posts, 'review_tie_breaker');
~~~~

The first argument in the function is the array of posts created by the default query in WordPress.  The second argument is the name of our custom sort function, which is shown below:

~~~~ php
function review_tie_breaker($a, $b) {
   // get the star value for each 
   $a_stars = get_post_meta($a->ID, 'stars-overall-rating', true);
   $b_stars = get_post_meta($b->ID, 'stars-overall-rating', true);
   // if it's not a tie, return which has more stars
   if ($a_stars != $b_stars) {
      return ((float)$a_stars > (float)$b_stars) ? -1 : 1;
   }
   // else, if they are tied, go to the priority tiebreaker...
 
   // get the priority value for each
   $a_priority = get_post_meta($a->ID, 'rating-priority', true);
   $b_priority = get_post_meta($b->ID, 'rating-priority', true);
 
   // if a priority value has not been entered, default to 0
   $a_priority = ($a_priority == '') ? 0 : (int)$a_priority;
   $b_priority = ($b_priority == '') ? 0 : (int)$b_priority;
 
   // if the priority is also equal, just return as a tie
   if ($a_priority == $b_priority) {
      return 0;
   }
   // if not, we return the priority comparison
   return ($a_priority < $b_priority) ? -1 : 1;
}
~~~~

### How the Tie-Breaker Function Works

The way the custom sort function works is by comparing two elements of the array (`$a` and `$b`, above), and deciding which one is “greater than” the other.  If `$a` is greater than `$b`, we should return a value of `1`.  If the opposite is true, we return `-1`.  If they are tied, we return `0`. 

The above function uses ternary operators to compare first the star ratings and then the priority values.  If the stars are not tied, it just returns which has the higher star rating, and never gets to the tie-breaker phase.  But if they are equal, we then compare the second criteria.

There is also a check to make sure the “priority” field has a value.  This is so that the user is not forced to input a value for every single review, just the ones that need to be tweaked.  Using this system, all that is required to bump a review up above another review with an equal star-rating is to insert a `-1` in the priority box.

I used this for a star rating system, but it could be used for any number of applications.  For example, if you wanted to order your posts by author, but for each author make sure they are in chronological order.
