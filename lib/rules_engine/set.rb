class RulesEngine::Set
  attr_reader :name,
              :root,
              :original,
              :multiple_outcomes

  def initialize(options = {})
    @root = options.fetch(:root)
    @name = options.fetch(:name)
    @original = options.fetch(:original, nil)
    @multiple_outcomes = options.fetch(:multiple_outcomes, false)
  end

  def multiple_outcomes?
    multiple_outcomes
  end
end
