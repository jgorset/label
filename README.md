# Label

[![Gem Version](https://img.shields.io/gem/v/label.svg)](https://rubygems.org/gems/label)
[![Build Status](https://img.shields.io/travis/jgorset/label.svg)](https://travis-ci.org/jgorset/label)

Label describes the gems in your Gemfile so you don't have to look them up to see what they do.

## Usage

Just run it:

```zsh
$ label
```

Then check out your beautiful new Gemfile:

```ruby
source 'http://rubygems.org'

# Flexible authentication solution for Rails with Warden
gem 'devise'

# Upload files in your Ruby applications, map them to a range of ORMs, store
# them on different backends.
gem 'carrierwave'

# RailsAdmin is a Rails engine that provides an easy-to-use interface for
# managing your data.
gem 'rails_admin'
```

Label will look for a `Gemfile` in your current working directory by default, but you can
tell it to look somewhere else if you like:

```zsh
$ label /path/to/Gemfile
```

## Installation

    $ gem install label

## I love you

Johannes Gorset made this. You should [tweet me](http://twitter.com/jgorset) if you can't get
it to work. In fact, you should tweet me anyway.
