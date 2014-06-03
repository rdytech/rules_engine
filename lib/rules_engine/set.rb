class RulesEngine::Set
  attr_reader :root, :name

  def initialize(root, name)
    @root = root
    @name = name
  end
end
