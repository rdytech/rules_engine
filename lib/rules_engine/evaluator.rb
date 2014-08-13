class RulesEngine::Evaluator
  attr_reader :condition, :context

  def initialize(options = {})
    @condition = options.fetch(:condition)
    @context = options.fetch(:context)
  end

  def evaluate
    begin
      BooleanDsl::Evaluator.new(condition, context).outcome
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
