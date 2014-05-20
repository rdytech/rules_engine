class RulesEngine::Action
  attr_accessor :action

  def initialize(action = nil)
    @action = action
  end

  def execute(object)
    puts "executing: #{action}"
    nil
  end
end
