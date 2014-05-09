# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rules_engine/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rules_engine'
  s.version     = RulesEngine::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Brenton Fletcher']
  s.email       = ['brentonf@jobready.com.au']
  s.homepage    = 'http://github.com/jobready/rules_engine'
  s.summary     = 'Gem for parsing and executing rules'
  s.description = 'Coming Soon'
  s.license       = 'MIT'

  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'cane', '~> 2.6'
  s.add_development_dependency 'byebug', '~> 2.7'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'coveralls'
  s.add_dependency 'activesupport'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
