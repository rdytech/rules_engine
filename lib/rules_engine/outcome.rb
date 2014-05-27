class RulesEngine::Outcome
  attr_accessor :category, :parameter

  def initialize(category, parameter)
    @category = category
    @parameter = parameter
  end

  def execute(object, logger)
    logger << "Performing action #{category}, #{parameter}"
    RulesEngine::Evaluator.new(parameter, object).evaluate
  end
end
