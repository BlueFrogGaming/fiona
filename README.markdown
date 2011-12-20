# Fiona - Rails 3 configuration data engine.

Fiona lets you store unstructured configuration data in your SQL database.
Examples include application settings and template data.
Any JSON compatible datastructures and values are permitted (integer, float, string, hash, array, true, false, null, etc).

## Requirements

* Rails 3.x (tested with Rails 3.1)

## Gem Installation

### With bundler

Add the following to your Gemfile and run the 'bundle' command:

    gem "fiona"

## Configuration

After you install the gem, you need to run Fiona's generator:

    rails generate fiona

## Usage

Create an instance of Template:

    t = Template.new(:key => 'some_template')
    t.some_var = 'some sweet value'
    t.save!

In the above example, 't' can have as many variables associated with it
as you want.  Their values can be any JSON supported datatype including
hashes, array, strings, etc.

### Subclassing

The Template class can be subclassed since it uses Rails STI.  The
included SettingsTemplate feature is an example of this.

### SettingsTemplate

Fiona comes with a template class named SettingsTemplate and an
associated Rails initializer. Together they simplify the management of
application settings. To begin using this feature you will need to
uncomment the code in config/initializers/settings.rb.  Your entire
application will then have access to the constant "S" which contains all
of your settings.

## TODO

* Create a generator for creating subclasses of Template.
* Improve caching.

## Contributing to Fiona

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Chad Remesch. See LICENSE.txt for
further details.
