class RulesEngine::Walker
  attr_reader :root, :object

  def initialize(root, object)
    @root = root
    @object = object
  end

  def walk
    node = root
    loop do
      node = node.execute(object)
      break unless node
    end
  end
end
