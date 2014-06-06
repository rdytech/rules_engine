class RulesEngine::Outcome
  attr_accessor :name, :reference, :parameter

  def initialize(name, reference, parameter)
    @name = name
    @reference = reference
    @parameter = parameter
  end
end
