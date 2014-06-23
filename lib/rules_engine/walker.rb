class RulesEngine::Walker
  attr_reader :sets, :object, :event_logger
  class_attribute :logger

  def initialize(options = {})
    @sets = Array(options.fetch(:set))
    @object = options.fetch(:object, nil)
    @event_logger = options.fetch(:event_logger)
  end

  def walk
    sets.each do |set|
      outcome = walk_set(set)
      return outcome if outcome
    end
    return nil
  end

  def walk_set(set)
    logger.info("Executing Rule Set #{set.name}")

    node = set.root
    loop do
      unless node.is_a?(RulesEngine::Condition)
        event_logger.add_event(set, node, nil) if node
        return node
      end

      which = node.execute(object)
      logger.info("Evaluated condition #{node.condition}, result is #{which} (overridden: #{node.override?})")

      event_logger.add_event(set, node, which)

      node = node.outcome(which)
    end
  end
end
