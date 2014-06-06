class RulesEngine::Evaluator
  attr_reader :condition, :object

  def initialize(condition, object)
    @condition = condition
    @object = object
  end

  def evaluate
    begin
      BooleanDsl::Evaluator.new(condition, object).outcome
    rescue Parslet::ParseFailed => error
      RulesEngine::Walker.logger.error("Parslet::ParseFailed")
      RulesEngine::Walker.logger.error("Condition was: #{condition}")
      RulesEngine::Walker.logger.error(error.cause.ascii_tree)
      raise error
    rescue BooleanDsl::EvaluationFailed => error
      RulesEngine::Walker.logger.error("BooleanDsl::EvaluationFailed")
      RulesEngine::Walker.logger.error("Condition was: #{condition}")
      RulesEngine::Walker.logger.error(error.message)
      raise error
    end
  end
end
