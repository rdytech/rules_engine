class RulesEngine::Condition
  attr_accessor :name,
                :condition,
                :when_true,
                :when_false,
                :original,
                :override,
                :when_true_outcome,
                :when_false_outcome,
                :when_true_condition,
                :when_false_condition

  def initialize(options = {})
    @name = options.fetch(:name)
    @condition = options.fetch(:condition)
    @when_true = options.fetch(:when_true, nil)
    @when_false = options.fetch(:when_false, nil)
    @original = options.fetch(:original, nil)
    @override = options.fetch(:override, nil)
    @when_true_outcome = options.fetch(:when_true_outcome, nil)
    @when_false_outcome = options.fetch(:when_false_outcome, nil)
    @when_true_condition = options.fetch(:when_true_condition, nil)
    @when_false_condition = options.fetch(:when_false_condition, nil)
  end

  def override?
    !override.nil?
  end

  def execute(context)
    if override?
      override
    else
      RulesEngine::Evaluator.new(condition: condition, context: context).evaluate
    end
  end

  def outcome(which)
    which ? when_true : when_false
  end

  def outcome_multiple(which)
    which ? when_true_condition : when_false_condition
  end

  # for multiple outcomes
  # might need to return a hash instead so that order is not important
  def outcomes(which)
    if which
      [when_true_outcome, when_true_condition]
    else
      [when_false_outcome, when_false_condition]
    end
  end
end

