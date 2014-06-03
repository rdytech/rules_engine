class RulesEngine::Outcome
  attr_accessor :reference, :parameter

  def initialize(reference, parameter)
    @reference = reference
    @parameter = parameter
  end
end
