require 'spec_helper'

describe 'Condition' do
  let(:true_action) { RulesEngine::Outcome.new(name: 'name', reference: 'true action', parameter: '1') }
  let(:false_action) { RulesEngine::Outcome.new(name: 'name', reference: 'false action', parameter: '1') }

  context 'Constructing a new instance from a hash' do

    let(:condition) { RulesEngine::Condition.new(name: 'name', condition: '2 > 1', when_true: true_action, when_false: false_action) }

    specify { expect(condition.name).to eq('name') }
    specify { expect(condition.condition).to eq('2 > 1') }
    specify { expect(condition.when_true).to eq(true_action) }
    specify { expect(condition.when_false).to eq(false_action) }

    context 'Missing required arguments' do
      context 'name' do
        specify { expect { RulesEngine::Condition.new(condition: '2 > 1', when_true: true_action, when_false: false_action) }.to raise_error }
      end
      context 'condition' do
        specify { expect { RulesEngine::Condition.new(name: 'name', when_true: true_action, when_false: false_action) }.to raise_error }
      end
    end
  end
end
