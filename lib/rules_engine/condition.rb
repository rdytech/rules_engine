class RulesEngine::Condition
  attr_accessor :name, :condition, :when_true, :when_false, :original, :override

  def initialize(options = {})
    @name = options.fetch(:name)
    @condition = options.fetch(:condition)
    @when_true = options.fetch(:when_true, nil)
    @when_false = options.fetch(:when_false, nil)
    @original = options.fetch(:original, nil)
    @override = options.fetch(:override, nil)
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
end

