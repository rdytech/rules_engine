class RulesEngine::Walker
  attr_reader :sets, :object
  class_attribute :logger

  def initialize(sets, object)
    @sets = sets
    @object = object
  end

  def walk
    sets.each do |set|
      logger.info("Executing Rule Set #{set.name}")

      result = walk_root(set.root)

      if result.nil?
        logger.info("Going to next Rule Set")
      else
        return result
      end
    end
  end

  def walk_root(root)
    node = root
    loop do
      break unless node.is_a?(RulesEngine::Condition)
      node = node.execute(object, logger)
    end

    node
  end
end
