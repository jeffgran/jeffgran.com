---
title: Reset rubygems' internal cache of known gems after maniuplating $LOAD_PATH
tags: ruby
author: Jeff Gran
layout: post
---

# Reset rubygems' internal cache of known gems after maniuplating $LOAD_PATH

When you require something via rubygems for the first time, it creates a list of "all known gem specficiations", meaning `.gemspec` files.

If you add something to the `$LOAD_PATH` that has more gems in it (in my case, this was a jar, because I'm in jruby at the moment), the new `.gemspec` files are in the new path are not known by rubygems, and it has the "all" set cached. You can see the cache with:

~~~ruby
Gem::Specification.class_variable_get(:@@all)
~~~

Here's how you can reset it after adding to the `$LOAD_PATH`:

~~~ruby
Gem::Specification.reset
~~~

This took me a few hours to figure out, so maybe this post will help someone.
