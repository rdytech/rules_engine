class RulesEngine::Condition
  attr_accessor :name, :condition, :when_true, :when_false

  def initialize(options = {})
    @name = options.fetch(:name)
    @condition = options.fetch(:condition)
    @when_true = options.fetch(:when_true, nil)
    @when_false = options.fetch(:when_false, nil)
  end

  def execute(object)
    RulesEngine::Evaluator.new(condition: condition, object: object).evaluate
  end

  def outcome(which)
    which ? when_true : when_false
  end
end

