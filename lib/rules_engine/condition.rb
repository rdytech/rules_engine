class RulesEngine::Condition
  attr_accessor :condition, :when_true, :when_false

  def initialize(condition = nil, when_true = nil, when_false = nil)
    @condition = condition
    @when_true = when_true
    @when_false = when_false
  end

  def execute(object)
    if RulesEngine::Evaluator.new(condition, object).evaluate
      when_true
    else
      when_false
    end
  end
end

