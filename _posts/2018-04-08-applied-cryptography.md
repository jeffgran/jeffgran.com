---
title: My Self-Study Plan for Applied Cryptography
author: Jeff Gran
layout: post
tags: cryptography
---

# My interest in Cryptography

I'm increasingly interested in steering my career towards cryptography. Two applications of cryptography especially interest me: **privacy** and **cryptocurrency**.

TL;DR I'm teaching myself this stuff with the list at the bottom.


## Privacy

There were headlines recently that Facebook has all this data on its users. Most everyone I know in software development were only surprised that other people were surprised. Of course Facebook (and Google, and Amazon, and Twitter, and every big "free" web application that exists) are harvesting data about you to sell to each other and to others, leading to a prominent culture of psychological manipulation based on data about you.

Anyway everyone knows that. It's how the world works. But it doesn't have to be. Anonymity is a value I hold and that I think more would hold if it were available to them. It's just simply not available, in a lot of cases. 

Facebook messenger is listening to your conversations. Signal messenger, by Open Whisper Systems, uses one of the most sophisticated cryptographic protocols invented. And it's just as easy to use as Facebook messenger but is completely private, end-to-end encrypted so that you can digitally "whisper" to your friends and family. I fundamentally believe that I have the right to communicate in private without eavesdroppers, but it's surprisingly rare to be able to do that in today's internet, and I want to dedicate my working life to helping make that possible (and easy!) for the average joe.

## Cryptocurrency

Everyone has heard of Bitcoin by now. I was a relatively early adopter and have moved on to other currencies now, but I still believe in the idea. The cool thing about cryptocurrency is the cryptographic proof of the public ledger. There's no such thing as counterfeit on the blockchain. Proof of Work works because of the "hard problem" vs "simple problem", in the same way that asymmetric cryptography does. You can't fake that you did the work to find a one-way hash of the transactions in the block. There's a part of me that revels in provable correctness and I like the blockchain because it has this, while traditional money does not. I have no idea what amount of dollars the Federal Reserve is creating out of thin air this month, and the only reason to believe that my bank is not scamming me is the government "manually" enforcing good behavior. I think the former is superior to the latter and I'd like to contribute to the future of this all-important system in society.


## Self-study

So I've decided to spend my free time studying this stuff so that I can start contributing to one or both of those two applications of cryptography, which I think will make the world a better place. There are a lot of things I have to learn. Even though I've been a software developer for about 10 years now, there are a lot of sub-disciplines with which I am rusty, or which I never learned properly in the first place. So I'm working on filling those gaps.

For that purpose, below is my self-selected curriculum to get myself up to speed on the things I'll need to know to make this transition. I'll keep this updated with my progress and changes/removals/additions to the list.


### Math and Computer Science
    
I want to have a deeper understanding of the math behind cryptography.

- **MIT Backround Math**
  - ~~*[Mathematics for Computer Science (MIT OpenCourseWare)](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-042j-mathematics-for-computer-science-spring-2015/)*~~
    - Finished. 
    - Includes primers on proofs, discrete math, DAGs and trees, counting, probability, etc.
  - ~~*[Single Variable Calculus (MIT OpenCourseWare)](https://ocw.mit.edu/courses/mathematics/18-01sc-single-variable-calculus-fall-2010/syllabus/)*~~
    - Finished (3/5 units, skipped advanced integration stuff because I don't think I need it for cryptography)
  - ~~*[Multivariate Calculus (MIT OpenCourseWare)](https://ocw.mit.edu/courses/mathematics/18-02sc-multivariable-calculus-fall-2010/Syllabus/)*~~
    - Finished (just the first unit, about background on vectors/matrices because I read somewhere that I need to learn Linear Algebra in order to understand elliptic curves)
- **Brilliant.org: 3 courses leading to Group Theory**
  - [Complex Algebra](https://brilliant.org/courses/complex-algebra/#course-map-modal)
  - [Number Theory](https://brilliant.org/courses/basic-number-theory/)
  - [Group Theory](https://brilliant.org/courses/group-theory/)
- **Probability**
  - [Statistics 110: Introduction to Probability by Harvard/edX](https://www.edx.org/course/introduction-to-probability-0)
- **Elliptic Curves and Galois Fields**
  - I haven't been able to find a good, straightforward online course or book about these specific topics. I'm open to suggestions.

### Cryptography

Cryptographic methods, protocols, history, etc. The meat.

- **~~["Introduction to Applied Cryptography" by University of Colorado (Coursera 4-course "Specialization")](https://www.coursera.org/specializations/introduction-applied-cryptography)~~ -- Finished [(Coursera Certificate)](https://www.coursera.org/account/accomplishments/specialization/SMHX4NSHFSRD)**
  - ~~Classical Cryptosystems and Core Concepts~~
    - Finished [(Coursera Certificate)](https://www.coursera.org/account/accomplishments/records/UF2XEQPE8FXB)
  - ~~Mathematical Foundations for Cryptography~~
    - Finished [(Coursera Certificate)](https://www.coursera.org/account/accomplishments/records/DCQ7NTC24G2Q)
  - ~~Symmetric Cryptography~~
    - Finished [(Coursera Certificate)](https://www.coursera.org/account/accomplishments/records/CNJGHDR8E93M)
  - ~~Asymmetric Cryptography and Key Management~~
    - Finished [(Coursera Certificate)](https://www.coursera.org/account/accomplishments/records/VK7MERCJXFGK)
- [Book: Serious Cryptography by Jean-Philippe Aumasson](https://nostarch.com/seriouscrypto)
  - In Progress
- [Coursera course: Cryptography I by Stanford University (Dan Boneh)](https://www.coursera.org/learn/crypto)
  - I've read a lot of people saying this is a great class. I assume it's a little more in-depth than the University of Colorado introduction, so I wanted to take that series first so that I'd have some basic understanding before I dive into this more difficult one.

### C++

C++ seems to be the lingua franca of cryptography so I need to get a little more familiar with it.

- [Book: "Accelerated C++" by Andrew Koenig and Barbara E. Moo](http://libertar.io/lab/wp-content/uploads/2017/03/Andrew-Koening-and-Barbara-E.-Moo-Accelerated-C-.pdf)
  - In Progress
  - I was looking for a book that would teach me C++ without wasting my time teaching me what a variable is. This seems to fit the bill!

### Networking and Network Security

I want to brush up on the details of network protocols and network security. I know enough to do my job as a web developer, but I want to study the details more closely.

- ["Computer Communications" by University of Colorado (Coursera 4-course "Specialization")](https://www.coursera.org/specializations/computer-communications)
  - or maybe [Cisco Networking Basics (Coursera 5-course "Specialization")](https://www.coursera.org/specializations/networking-basics)
- ["Fundamentals of Computer Network Security" by University of Colorado (Coursera 4-course "Specialization")](https://www.coursera.org/specializations/computer-network-security)
