class RulesEngine::Walker
  attr_reader :sets, :context, :event_logger
  class_attribute :logger

  def initialize(options = {})
    @sets = Array(options.fetch(:set))
    @context = options.fetch(:context, {})
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
    outcome = nil
    condition = nil
    outcomes = []

    loop do
      if set.multiple_outcomes?
        if outcome
          add_event(set, outcome, nil)
          outcomes << outcome
        end
        return outcomes unless node
      else
        unless node.is_a?(RulesEngine::Condition)
          add_event(set, node, nil) if node
          return node
        end
      end

      which = node.execute(context)
      logger.info("Evaluated condition #{node.condition}, result is #{which} (overridden: #{node.override?})")
      add_event(set, node, which)

      if set.multiple_outcomes?
        outcome, node = node.outcomes(which)
      else
        node = node.outcome(which)
      end
    end
  end

  def add_event(set, node, which)
    event_logger.add_event(set, node, which) if event_logger
    # puts "Add Event - set: #{set.name}, node: #{node.name}, which: #{which}"
  end
end
