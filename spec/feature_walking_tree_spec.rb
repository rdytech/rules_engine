require 'spec_helper'

describe 'walking the tree' do
  let(:event_logger) do
    obj = Object.new
    allow(obj).to receive(:add_event)
    obj
  end

  let(:set) { RulesEngine::Set.new(root: root, name: 'test') }
  let(:walker) { RulesEngine::Walker.new(set: set, event_logger: event_logger) }

  context 'for a tree 1 level deep (only a root action)' do
    let(:root) { RulesEngine::Outcome.new(name: 'name', values: [{ reference: 'an action', parameter: '1' }]) }

    it 'executes the action' do
      walker = RulesEngine::Walker.new(set: set, event_logger: event_logger)

      expect(walker.walk).to eq(root)
    end
  end

  context 'for a tree 2 levels deep' do
    let(:true_action) { RulesEngine::Outcome.new(name: 'name', values: [{ reference: 'true action', parameter: '1' }]) }
    let(:false_action) { RulesEngine::Outcome.new(name: 'name', values: [{ reference: 'false action', parameter: '1' }]) }

    context 'executes the true action' do
      let(:root) { RulesEngine::Condition.new(name: 'name', condition: '2 > 1', when_true: true_action, when_false: false_action) }

      specify { expect(walker.walk).to eq(true_action) }
    end

    context 'executes the false action' do
      let(:root) { RulesEngine::Condition.new(name: 'name', condition: '2 < 1', when_true: true_action, when_false: false_action) }

      specify { expect(walker.walk).to eq(false_action) }
    end
  end
end
