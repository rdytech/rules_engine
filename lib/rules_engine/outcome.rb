class RulesEngine::Outcome
  attr_accessor :category, :parameter

  def initialize(category, parameter)
    @category = category
    @parameter = parameter
  end

  def execute(object, logger)
    logger << "Performing action #{category}, #{parameter}"
    # TODO: perform the action on the object
    "executing: #{category}, #{parameter}"
  end
end
