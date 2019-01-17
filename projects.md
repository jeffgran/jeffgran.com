---
layout: page
title: Projects
---

# Projects

This page highlights open source projects I've built or contributed to.

Many of them are unfinished, because... well because I have a job and a family and I don't have much time for hobby projects. Maybe when I retire.

## Ruby

### CodeDoc [(github)](https://github.com/jeffgran/code_doc)

This one was a good idea! I just never finished it. It was a system to document your ruby code with ruby code. I always thought that inventing another mini-language inside comments of the real language was dumb. I still do. 

One of the great things about emacs is its documentation. Everything is documented. A big reason everything is documented is that emacs lisp is documentation-aware. Docs are built into the language. I think Python has a little bit of that too. But I thought it could be better. 

It was inspired by the way `rake` does task documentation. You have code like:

```ruby
desc "this is the description of the task"
task :a_task do 
  # ...code
end
```

I thought, hey that's pretty neat, why can't we do all of documentation that way? So I started implementing something that would interpret this:

```ruby
desc 'this is the #foo method. it does nothing.'
arg :arg, 'this is the arg. it is not used.'
ret 'the string "foo"'
def foo(arg)
  "foo"
end
```

And could output the args, return value, and description in various formats. Taken to a crazy enough level this could actually end up as a static type checker... but the first plan was to make the ruby VM throw warnings and/or exceptions if you forgot to add docs, to enforce a documentation habit.


### Gangsta [(github)](https://github.com/jeffgran/Gangsta)

This was another grandiose idea. I wanted to make a glue layer that would take an object model, and output it in various formats (more of which could be added by the user, of course), like json, xml, RDFa html, etc. And also go the other way, from the representation back to the object model. And it would be driven by a DSL in ruby where you defined what properties of your class would be part of the object model and define how to get/set those properties on de/seralization. Looking back now, this was basically an object mapper thing like CORBA or something. The github readme has more. I never finished the code.

### MD5 [(github)](https://github.com/jeffgran/crypto/blob/master/md52.rb)

This one time, I wrote an MD5 implementation from scratch in pure ruby. We were using a lot of hash functions all over the place at OpenLogic (it was actually really cool what we did... but that's another story). I wanted to better understand how a hash function works, so I decided to pick one and implement it for learning purposes...

I did finish this one. One thing I learned was how this family of hash functions works, and the other thing I learned was that ruby SUCKS at bits-and-bytes-level code. There are no bytes in ruby, no hex literals or binary literals, there's just strings and this crazy ass way of transforming strings to other types using syntax like `string.reverse.unpack("L<").first`. Here `"L"` means what size of int you want to get out of the string and `"<"` is which endianness you want.

Anyway it works, I tested against the expected values in the RFC.

### OpenID Couch Rest Model Store [(github)](https://github.com/jeffgran/openid_couch_rest_model_store)

It's not much but it's the first open source ruby gem I ever published. We were starting a greenfield side project (which never ended up getting off the ground). We were trying to be all NoSQL-modern, which was the style at the time, so we were using Couch DB and Open ID. I forked an existing storage adapter for the OpenID gem to make it use Couch. Probably no one ever used it.

## Javascript

### Hex Grid [(github)](https://github.com/jeffgran/adroit-hex-grid)

One of my back-burner side projects is an html5/canvas game that uses a hex grid. I didn't find a hex grid library that I liked so I wrote one and open sourced it. 

I architected this library to be able to use different adapters for storage (like an in memory database or save to text file, etc), and different rendering adapters. This code is just the hex grid logic itself, like what terran and objects are in each cell, how far apart one cell is from another, and other things like that.

This library is complete, but the game I'm writing using it not very far along. 

### Atom Selection Mode Plugin [(github)](https://github.com/jeffgran/atom-selection-mode)

For a while I tried switching to Atom as my editor. I couldn't stick with it; I'm back to emacs now. But while I was there I wanted to replicate some of my emacs functionality and so I wrote a couple of plugins. This one emulates emacs' `transient-mark-mode` where you can set a mark and then all cursor movement expands/collapses the selection from that mark. It's so second-nature to me now that I can't live without it.

This works and I believe a few people are actually using it out there!

### Atom Comint Mode [(github)](https://github.com/jeffgran/atom-comint-mode)

This was an attempt at bringing my favorite feature of emacs to atom. I failed. There are some things that atom just can't do, and I ran into the limits here. So I abandoned the project. 

`comint-mode` in emacs is where you have some kind of REPL (typically your bash/zsh/fish/whatever shell) inside an emacs buffer. It's seriously my favorite thing and it's the main reason I still haven't left emacs for something more modern. 

I did get this sorta working. It spawns a shell process and pipes the input from the atom buffer to it, and its output back to the atom buffer. It's sort of usable. But it needs more work to be "production-ready," and again, I ran in to missing APIs in atom so I couldn't continue.

### IEVS.js [(github)](https://github.com/jeffgran/ievs.js)

This is a javascript rewrite of a piece of C code written by a man named Warren D Smith. He named it the "infinitely extendable voting system" (IEVS) comparison engine. Its job is to simulate voting in different voting systems (e.g. Plurality, Approval, Score, Instant Runoff, etc). I got inspired to write a JS version of it and try some different simulations based on real data from my home state of Colorado in some tight 3-way state legilsature races where it's likely the Spoiler Effect changed the outcome. 

I never finished it.

## Emacs Lisp

### jg-quicknav [(github)](https://github.com/jeffgran/jg-quicknav) [(blog post)](/2013/04/02/introducing-jg-quicknav.html)

I wrote this emacs package because I couldn't find one that navigated to open a file like I wanted to. I use it every day. It's great.

### elscreen-buffer-group [(github)](https://github.com/jeffgran/elscreen-buffer-group)

Similarly, I wrote this to help me have multiple projects open in different "tabs" (via `elscreen` "screens") and have them each keep a separate buffer list. I also use this every day.

### My Emacs Config [(github)](https://github.com/jeffgran/my-emacs)

I mean, I wrote a whole lot of lisp that's in here. I try to keep it organized but it's a little scattered, I guess. Probably not that interesting but there you go.

## Rust

### Coursera Algorithms Homework [(github)](https://github.com/jeffgran/coursera-algorithms.rs)

I took a "Data Structures and Algorithms" course on Coursera, and it required you to implement the algorithms but you could do it in any language. You get credit by running your code against a given data set and submitting the answer, so you prove you wrote a working algorithm. 

So anyway I decided to use that opportunity to write some rust. So here are some basic college-level algorithms implemented in rust.

I still want to get back to this and go through the other 3 courses in the series.

## Elixir

### Aho-Corasick [(github)](https://github.com/jeffgran/aho_corasick.ex)

I came across teh Aho-Corasick text-search algorithm while I was at OpenLogic. A colleague and friend of mine, Doug Lovell, found it and it turned out to be the perfect solution to a problem we had at the time. I kind of got fascinated with it.

So when I was learning Elixir, I decided to challenge myself to implement this algorithm in Elixir. This code is the result.

## Other

### ManuForm Keyboard [(github)](https://github.com/jeffgran/ManuForm) [(geekhack build log)](https://geekhack.org/index.php?topic=46015.0)

This isn't code so much as a physical/hardware project. I built my own keyboard. I used some python code to generate some of the 3D model but most of it was done by hand.

You can see a lot more about the project and the result in the links above.

## C++

### Bitcoin XT Commits [(github)](https://github.com/bitcoinxt/bitcoinxt/pulls?q=is%3Apr+author%3Ajeffgran)

It's really barely anything... but hey I'm proud of it! I have made a few contributions to the BitcoinXT Bitcoin Cash client. I would like to contribute more... maybe when I retire.
