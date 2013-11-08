# RLicker
[![Build Status](https://secure.travis-ci.org/ben-biddington/rlicker.png)](http://travis-ci.org/ben-biddington/rlicker)

Why should I have to subscribe to one particular browser driver? Each seems to have incompatible DSLs and different ideas about abstraction. Changing from one to the other is a non-trivial exercise. 

RLicker aims to perform a kind of [dependency inversion](http://www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf), providing an abstraction to program against, enabling the implementation to be switched easily -- even at runtime. 

I am starting with [capybara webkit](https://github.com/thoughtbot/capybara-webkit) as a reference implementation because it rules.

# References
* [Continuous Delivery](http://martinfowler.com/books.html#continuousDelivery)
* [GOOS](http://www.growing-object-oriented-software.com)