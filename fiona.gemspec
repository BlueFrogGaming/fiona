# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fiona/version'

Gem::Specification.new do |gem|
  gem.name          = 'fiona'
  gem.version       = Fiona::VERSION
  gem.authors       = ['Chad Remesch']
  gem.email         = ['chad@remesch.com']
  gem.description   = %q{Easily store and use template data with Rails.}
  gem.summary       = %q{A simple to use gem for storing template data with Rails (ActiveRecord).}
  gem.homepage      = 'https://github.com/BlueFrogGaming/fiona'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('activerecord', '>= 3')
end
