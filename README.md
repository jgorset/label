# Label

Label labels the gems in your Gemfile.

## Installation

    $ gem install label

## Usage

    $ cd /path/to/Gemfile
    $ label

```ruby

source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Flexible authentication solution for Rails with Warden
gem 'devise'

# Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem 'carrierwave'

# RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data.
gem 'rails_admin'
```

Existing labels are kept by default, but you can set `--force` to overwrite them.

## I love you

Johannes Gorset made this. You should [tweet me](http://twitter.com/jgorset) if you can't get
it to work. In fact, you should tweet me anyway.
