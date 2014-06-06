class RulesEngine::Condition
  attr_accessor :name, :condition, :when_true, :when_false

  def initialize(name = nil, condition = nil, when_true = nil, when_false = nil)
    @name = name
    @condition = condition
    @when_true = when_true
    @when_false = when_false
  end

  def execute(object)
    RulesEngine::Evaluator.new(condition, object).evaluate
  end

  def outcome(which)
    which ? when_true : when_false
  end
end

