# Loggem [![Build Status](https://travis-ci.org/emartech/loggem.svg?branch=master)](https://travis-ci.org/emartech/loggem) [![Code Climate](https://codeclimate.com/github/emartech/loggem/badges/gpa.svg)](https://codeclimate.com/github/emartech/loggem) [![Gem Version](https://badge.fury.io/rb/loggem.svg)](http://badge.fury.io/rb/loggem)

Simple log wrapper with different formatters for Rails. Minimal ActiveRecord/Sequel support, so far.

## Installation

Add it your application's Gemfile and run `bundle`:

    gem 'loggem'

## Usage
Add the following lines to the `config/application.rb`

    config.loggem.enabled = true
    # use your favorite logger (or skip it setting it to use STDOUT)
    config.loggem.logger = ::Logging.logger.root
    # replace activerecord's logsubscriber to the loggem's one
    config.loggem.extensions = %w[active_record]

## Contributing

1. Fork it ( https://github.com/emartech/loggem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
