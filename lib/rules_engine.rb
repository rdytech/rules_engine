require 'active_support/all'
require 'boolean_dsl'

require 'logger'

module RulesEngine
end

require 'rules_engine/set'
require 'rules_engine/evaluator'
require 'rules_engine/condition'
require 'rules_engine/outcome'
require 'rules_engine/walker'

RulesEngine::Walker.logger = Logger.new(STDOUT)
RulesEngine::Walker.logger.level = Logger::ERROR
