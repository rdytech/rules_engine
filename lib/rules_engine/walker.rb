class RulesEngine::Walker
  attr_reader :sets, :object
  class_attribute :logger

  def initialize(sets, object)
    @sets = sets
    @object = object
  end

  def walk
    Hash[sets.map { |set| [set, walk_set(set)] }]
  end

  def walk_set(set)
    logger.info("Executing Rule Set #{set.name}")

    node = set.root
    loop do
      break unless node.is_a?(RulesEngine::Condition)
      node = node.execute(object, logger)
    end

    node
  end
end
