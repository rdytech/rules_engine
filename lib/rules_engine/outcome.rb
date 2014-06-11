class RulesEngine::Outcome
  attr_accessor :name, :reference, :parameter

  def initialize(options = {})
    @name = options.fetch(:name)
    @reference = options.fetch(:reference)
    @parameter = options.fetch(:parameter)
  end
end
