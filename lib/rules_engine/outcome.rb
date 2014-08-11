class RulesEngine::Outcome
  attr_accessor :name, :values

  def initialize(options = {})
    @name = options.fetch(:name)
    @values = options.fetch(:values)
  end
end
