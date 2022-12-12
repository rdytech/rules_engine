# Enterprise Rules Engine

[![Code Climate](https://codeclimate.com/github/jobready/rules_engine.png)](https://codeclimate.com/github/jobready/rules_engine)
[![Test Coverage](https://codeclimate.com/github/jobready/rules_engine/badges/coverage.svg)](https://codeclimate.com/github/jobready/rules_engine)
[![Build status](https://badge.buildbox.io/72c3ec06702dc7e379c38425f9402b7c89735f18ff7914aa2f.svg)](https://buildbox.io/accounts/jobready/projects/rules-engine)

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

Single outcome:

```ruby
true_outcome = RulesEngine::Outcome.new(name: "Outcome 1", values: "Outcome 1 Values")
false_outcome = RulesEngine::Outcome.new(name: "Outcome 2", values: "Outcome 2 Values")
root = RulesEngine::Condition.new(name: "Root", condition: "2 > 1", when_true: true_outcome, when_false: false_outcome)
set = RulesEngine::Set.new(name: "Single Outcome", root: root)
walker = RulesEngine::Walker.new(set: set, event_logger: nil)
walker.walk

# Executing Rule Set Single Outcome
# Evaluated condition 2 > 1, result is true (overridden: false)
# => #<RulesEngine::Outcome:... @name="Outcome 1", @values="Outcome 1 Values">
```

Multiple outcomes:

```ruby
outcome_1 = RulesEngine::Outcome.new(name: "Outcome 1", values: "Outcome 1 Values")
outcome_2 = RulesEngine::Outcome.new(name: "Outcome 2", values: "Outcome 2 Values")
outcome_3 = RulesEngine::Outcome.new(name: "Outcome 3", values: "Outcome 3 Values")
outcome_4 = RulesEngine::Outcome.new(name: "Outcome 4", values: "Outcome 4 Values")
condition_1 = RulesEngine::Condition.new(name: "Condition 1", condition: "2 < 1", when_true_outcome: outcome_3, when_false_outcome: outcome_4)
root = RulesEngine::Condition.new(name: "Root", condition: "2 > 1", when_true_outcome: outcome_1, when_true_condition: condition_1, when_false_outcome: outcome_2, when_false_condition: condition_1)
set = RulesEngine::Set.new(name: "Multiple Outcomes", root: root, multiple_outcomes: true)
walker = RulesEngine::Walker.new(set: set, event_logger: nil)
walker.walk

# Executing Rule Set Multiple Outcomes
# Evaluated condition 2 > 1, result is true (overridden: false)
# Evaluated condition 2 < 1, result is false (overridden: false)
# => [#<RulesEngine::Outcome:... @name="Outcome 1", @values="Outcome 1 Values">,
      #<RulesEngine::Outcome:... @name="Outcome 4", @values="Outcome 4 Values">]
```

## Contributing

1. Fork it ( http://github.com/jobready/rules_engine )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
