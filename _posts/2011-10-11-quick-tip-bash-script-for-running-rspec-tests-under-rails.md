---
title: "Quick Tip: Bash Script for Running RSpec Tests Under Rails"
author: Jeff Gran
layout: post
tags: ruby bash
---
# Quick Tip: Bash Script for Running RSpec Tests Under Rails

This will be specific to our particular setup but could easily be adapted for other similar use cases.

Basically, I got tired of typing:

~~~~ bash
$ rake spec SPEC=spec/acceptance/path/to/file.rb SPEC_OPTS='--line 42'
~~~~

…in order to re-run a single test after attempting to fix it. The rspec output gives a stack trace that shows the file/line number the failure occured on, like this:

~~~~ bash
./spec/acceptance/path/to/file.rb:42
~~~~

So I made a bash script that lets me just copy that line and then run 

~~~~ bash
$ test [pasted line]
~~~~

and it will run the test again. Here it is:

~~~~ bash
function test() {
   local a1="$1"
   local a2="$2"
   if [[ $1 == *:* ]]; then
     arr=(${1//:/ }); a1="${arr[0]}"
     a2="${arr[1]}"
   fi
   local spec="$a1"
   if [ -n "$a2" ]; then local opts="--line ${a2}"; fi;
   if [ -z "$opts" ]; then
     echo rake spec SPEC=${spec}
     bundle exec rake spec SPEC=${spec}
   else
     echo rake spec SPEC=${spec} SPEC_OPTS="${opts}"
     bundle exec rake spec SPEC=${spec} SPEC_OPTS="${opts}"
   fi
}
~~~~
