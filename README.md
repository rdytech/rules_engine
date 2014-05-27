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

true_outcome = RulesEngine::Outcome.new("true outcome")
false_outcome = RulesEngine::Outcome.new("false outcome")
tree = RulesEngine::Condition.new("2 > 1", true_outcome, false_outcome)
walker = RulesEngine::Walker.new(tree, nil)
```

## Contributing

1. Fork it ( http://github.com/jobready/rules_engine )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
