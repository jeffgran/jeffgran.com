---
title: Javascript vs. jQuery vs. the DOM
author: Jeff Gran
layout: post
excerpt: "When I first started learning about Javascript, it took me a little while before I could wrap my head around the distinctions and relationships between Javascript, jQuery and the DOM.  So I thought I would lay out what I've learned so that it might help someone where I was."
tags: javascript jQuery Web
---
# Javascript vs. jQuery vs. the DOM

When I first started learning about Javascript, it took me a little while before I could wrap my head around the distinctions and relationships between Javascript, jQuery and the DOM.  So I thought I would lay out what I’ve learned so that it might help someone where I was.

### Javascript

Javascript is a programming language.  It comes standard with most modern web browsers.  It is also the same language that is used in Flash (where it’s called ActionScript), and can be used to write scripts in Photoshop, Illustrator, etc.  In the context of a web browser, it is often used to manipulate the DOM (see below).

### jQuery

jQuery is a Javascript library, meaning that it is essentially a collection of functions written in Javascript that can be used to make the programmer’s job easier.  Common tasks that take more lines of code with traditional Javascript can be executed with calls to the jQuery functions.  There are several other Javascript libraries out there that fill the same need.  For one reason or another, jQuery seems to be the most popular library of the day.

### The DOM

The Document Object Model (DOM), is just that – a model for representing and interacting with an XML, XHTML, or HTML document.  Our HTML documents are created by typing tags in plain text, and the DOM is a way to access the tags and the structure of the “tag tree”. 

For example, instead of using regular expressions to find the text that represents a tag with a specific ID attribute, we can ask the DOM which of its tags has that ID.  Javascript is not part of the DOM or vice-versa, but Javascript in the browser does include some intelligence about the DOM – for example, the getElementById() function. 

One of the main advantages of jQuery is the extra intelligence it has regarding the DOM.  With it, you access and create DOM elements (tags) by using the many selectors and traversing operations it offers.
