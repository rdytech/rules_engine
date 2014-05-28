class RulesEngine::Evaluator
  attr_reader :condition, :object

  def initialize(condition, object)
    @condition = condition
    @object = object
  end

  def evaluate
    BooleanDsl::Evaluator.new(condition, object).outcome
  end
end
