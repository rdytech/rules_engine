# Enterprise Rules Engine

[![Code Climate](https://codeclimate.com/github/jobready/rules_engine.png)](https://codeclimate.com/github/jobready/rules_engine)
[![Build Status](https://travis-ci.org/jobready/rules_engine.svg)](https://travis-ci.org/jobready/rules_engine)


An enterprise rules engine for all your needs

Uses the [Boolean DSL](https://github.com/jobready/boolean_dsl) gem for handling logic

## Installation

Add this line to your application's Gemfile:

    gem 'rules_engine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rules_engine

## Usage

Require everything

```ruby
require 'rules_engine'
    @name = options.fetch(:name)
    @reference = options.fetch(:reference)
    @parameter = options.fetch(:parameter)

true_outcome = RulesEngine::Outcome.new(reference:'some category', name:'true outcome',parameter:'some parameter')
false_outcome = RulesEngine::Outcome.new(reference:'some category', 'name:false outcome', parameter:'another parameter')
root_rule = RulesEngine::Condition.new(name:'condition name', condition:'2 > 1', when_true:true_outcome, when_false:false_outcome)
set = RulesEngine::Set.new(root:root_rule, name:'rule set name')
walker = RulesEngine::Walker.new(set:set, object:some_object)
walker.walk
```

## Contributing

1. Fork it ( http://github.com/jobready/rules_engine )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
