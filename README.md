# Enterprise Rules Engine

[![Code Climate](https://codeclimate.com/github/jobready/rules_engine.png)](https://codeclimate.com/github/jobready/rules_engine)
[![Build Status](https://travis-ci.org/jobready/rules_engine.svg)](https://travis-ci.org/jobready/rules_engine)


An enterprise rules engine for all your needs


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

true_outcome = RulesEngine::Outcome.new("some category", "true outcome")
false_outcome = RulesEngine::Outcome.new("some category", "false outcome")
root_rule = RulesEngine::Condition.new("2 > 1", true_outcome, false_outcome)
set = RulesEngine::Set.new(root_rule, "rule set name")
walker = RulesEngine::Walker.new([set], some_object)
walker.walk
```

## Contributing

1. Fork it ( http://github.com/jobready/rules_engine )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
