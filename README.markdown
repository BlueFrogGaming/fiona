# Fiona - Rails 3 configuration data engine.

Fiona lets you store unstructured configuration data in your SQL database.
Examples include application settings and template data.
Any JSON compatible datastructures and values are permitted (integer, float, string, hash, array, true, false, null, etc).

## Requirements

* Activerecord (tested with Rails 3.1)

## Gem Installation

### With bundler

Add the following to your Gemfile and run the 'bundle' command to update your Gemfile.lock:

    gem "fiona"

### Without bundler

    gem install "fiona"

## configuration

After you install the gem, you need to generate Fiona's migration:

    rails generate fiona

This should create a migration named create_fiona_tables.rb in your Rails project.

## Usage

Fiona has uses two models (Template and TemplateAttribute).
Template is an STI table so it is recommended that you subclass it as necessary.

Example app/models/setting_template.rb:

    class SettingTemplate < Template
    end

Create a template for application settings:

    settings = SettingTemplate.new
    settings.key = 'my_settings'
    settings.app_name = 'My cool app'
    settings.domain_name = 'somedomain.com'
    settings.email_addresses = {:support => 'support@somedomain.com', :sales => 'sales@somedomain.com'}
    settings.save!

Create a convenient constant for accessing your settings (config/initializers/fiona.rb):

    SETTINGS = SettingTemplate.find_by_key('my_settings')

You can now access your settings at any time:

    puts SETTINGS.domain_name

You can change your settings easily whenever you want:

    SETTINGS.whatever = 5
    SETTINGS.save!

Note: you will need to restart your Rails processes whenever settings change in order for all processes to see the changes.

## TODO

* Create a generator for creating subclasses of Template.
* Keep projects clean by storing all template subclasses in app/templates instead of the models directory.
* Create a singleton for simplifying template access.
* Improve caching.

## Contributing to fiona

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
