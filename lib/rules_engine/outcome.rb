class RulesEngine::Outcome
  attr_accessor :category, :parameter

  def initialize(category, parameter)
    @category = category
    @parameter = parameter
  end
end
