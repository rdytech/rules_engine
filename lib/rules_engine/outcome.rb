class RulesEngine::Outcome
  attr_accessor :name, :values, :reference

  def initialize(options = {})
    @name = options.fetch(:name)
    @values = options.fetch(:values)
    @reference = options.fetch(:reference, nil)
  end
end
