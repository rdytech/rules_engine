class RulesEngine::Set
  attr_reader :name,
              :root,
              :original

  def initialize(options = {})
    @root = options.fetch(:root)
    @name = options.fetch(:name)
    @original = options.fetch(:original, nil)
  end
end
