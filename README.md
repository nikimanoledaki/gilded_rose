# Gilded Rose Refactoring Kata

[![Maintainability](https://api.codeclimate.com/v1/badges/1cdf45b157d192f356f6/maintainability)](https://codeclimate.com/github/nikimanoledaki/gilded_rose/maintainability)

## Description

The Gilded Rose challenge is a famous refactoring and testing challenge that was originally written in C++ by Terry Hughes. I chose to do this kata because it is an good introduction to working with legacy code, which is a big part of what software developers do when they join a new team. It is therefore important to practice reading, testing, and refactoring code written by someone else.

The version that I am working with here is written in Ruby and published on Emily Bache's Github. Have a look at the ["Gilded Rose Requirements"](https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/master/GildedRoseRequirements.txt).

## Technologies
The refactoring in Ruby followed a strict Test-Driven Development process where each new step incremented the code's complexity. RSpec was used to run the tests.

## Getting started

```
$ git clone https://github.com/nikimanoledaki/gilded_rose.git 
$ bundle install
```

## How to use
In your command line, invoke IRB with the gilded_rose.rb file with the following command:
```
$ irb -r ./lib/gilded_rose.rb 
> items = [Item.new('foo', 0, 0)]
> gilded_rose = GildedRose.new(items)
> gilded_rose.update_quality
```

## How to test

Run the rspec tests:
```
$ rspec
```

The current coverage is 94.55%.
