class RulesEngine::Evaluator
  attr_reader :condition, :object

  def initialize(condition, object)
    @condition = condition
    @object = object
  end

  def evaluate(logger)
    begin
      BooleanDsl::Evaluator.new(condition, object).outcome
    rescue Parslet::ParseFailed => error
      logger.error("Parslet::ParseFailed")
      logger.error("Condition was: #{condition}")
      logger.error(error.cause.ascii_tree)
    rescue BooleanDsl::EvaluationFailed => error
      logger.error("BooleanDsl::EvaluationFailed")
      logger.error("Condition was: #{condition}")
      logger.error(error.message)
    end
  end
end
