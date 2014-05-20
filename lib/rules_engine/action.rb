class RulesEngine::Action
  attr_accessor :action

  def initialize(action = nil)
    @action = action
  end

  def execute(object)
    # TODO: perform the action on the object
    "executing: #{action}"
  end
end
