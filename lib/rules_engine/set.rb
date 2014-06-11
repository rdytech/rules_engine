class RulesEngine::Set
  attr_reader :root, :name

  def initialize(options = {})
    @root = options.fetch(:root)
    @name = options.fetch(:name)
  end
end
