About
-----
Rails clone of [Google Moderator](http://en.wikipedia.org/wiki/Google_Moderator). In early development stage.

Background
----------
This app is part of my online portfolio, showcasing a functioning app developed in a test-first (BDD) manner. As I am not a designer, I have not put much effort into the visual styling of the app -- it is basic, but clean.

Prerequisites
------------
Ruby 1.9.2

Documentation
-------------
[Living documentation is published on Relish](http://relishapp.com/andyw8/townhallapp)

Build Status
------------
[![Build Status](http://travis-ci.org/andyw8/townhallapp.png)](http://travis-ci.org/andyw8/townhallapp)

BDD Strategy
------------
* RSpec, shoulda, factory_girl, Cucumber
* factory_girl used only for Cucumber features, not model specs
* 100% coverage on models (using CoverMe for reporting)
* No specs for views, controllers, helpers or routing - Cucumber is sufficient
* Model specs do not hit the real database (by using NullDB)
* Continuous integration provided by [Travis CI](http://travis-ci.org/andyw8/townhallapp)
