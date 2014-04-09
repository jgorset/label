# Label

[![Gem Version](https://img.shields.io/gem/v/label.svg)](https://rubygems.org/gems/label)
[![Build Status](https://img.shields.io/travis/jgorset/label.svg)](https://travis-ci.org/jgorset/label)
[![Dependency Status](https://img.shields.io/gemnasium/jgorset/label.svg)](https://gemnasium.com/jgorset/label)
[![Code Climate](https://img.shields.io/codeclimate/github/jgorset/label.svg)](https://codeclimate.com/github/jgorset/label)
[![Coverage Status](https://img.shields.io/coveralls/jgorset/label.svg)](https://coveralls.io/r/jgorset/label)

Label labels the gems in your Gemfile.

## Installation

    $ gem install label

## Usage

```zsh
$ label
```

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

## I love you

Johannes Gorset made this. You should [tweet me](http://twitter.com/jgorset) if you can't get
it to work. In fact, you should tweet me anyway.
