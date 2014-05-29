class RulesEngine::Condition
  attr_accessor :condition, :when_true, :when_false

  def initialize(condition = nil, when_true = nil, when_false = nil)
    @condition = condition
    @when_true = when_true
    @when_false = when_false
  end

  def execute(object, logger)
    if RulesEngine::Evaluator.new(condition, object).evaluate(logger)
      logger << "Evaluating condition #{condition}, result is true"
      when_true
    else
      logger << "Evaluating condition #{condition}, result is false"
      when_false
    end
  end
end

