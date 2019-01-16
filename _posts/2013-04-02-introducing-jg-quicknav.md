---
title: Introducing jg-quicknav
author: Jeff Gran
layout: post
tags: announcement lisp emacs
---
# Introducing jg-quicknav

## What

`` `jg-quicknav' `` is an emacs plugin for navigating the file system and opening files. It also connects with `` `dired' `` and soon with `` `shell-mode' `` as well.

I've been using it all day every day for a month or so and I love it, so hopefully it will be useful to someone else too. It's the first real emacs package I've written.

## Why

I like `` `ido-find-file' `` but I don't like how it's in the minibuffer. You can't see the full set of your options at once, and it's hard to keep track of when you "wrap around" to the beginning again.

I want a file-open dialog that is as fast as possible (fuzzy-matching, `RET` to select a file/dir), so I made one. I tried to make it extendable and pretty too.

## How

The code is available on [github][]. Get it into your `` load-path `` somewhere and require it with `` (require 'jg-quicknav) ``.

Then you'll need to assign a key to it. I use something like this:

~~~~ elisp
(define-key my-favorite-key-map (kbd "C-o") 'jg-quicknav)
~~~~

Substitute your favorite keymap (`` `global-map' `` if you must) and key sequence.

Once you enter `` `jg-quicknav' `` mode, use `` C-n `` and `` C-p `` to move your selection up and down, and `` RET `` to open a file or drill-down into a directory. `` C-g `` quits.

Use `` C-, `` to go "back", or up a directory, and `` C-. `` to go "forward" or down a directory. The "forward" command only works after going "back" in the same session.

You can also hit `` C-/ `` to enter `` `dired' `` while jg-navigating.


## Customizing

I assume you'll want to change the key bindings that are in play when quick-navigating, so I made a mode map that you can edit however you like. For example, to change the dired binding to `` C-x d ``, do this:

~~~~ elisp
(define-key jg-quicknav-mode-map (kbd "C-x d") 'jgqn-dired)
~~~~

See the source code at [github][] for more detail.

[github]: http://github.com/jeffgran/jg-quicknav
