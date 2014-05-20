class RulesEngine::Walker
  attr_reader :root, :object

  def initialize(root, object)
    @root = root
    @object = object
  end

  def walk
    node = root
    loop do
      break if node.is_a?(RulesEngine::Action)
      node = node.execute(object)
    end

    node.execute(object)
  end
end
