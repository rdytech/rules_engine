require 'spec_helper'

describe 'Evaluator' do
  let(:condition) { RulesEngine::Condition.new(name: 'name', condition: '2 > 1') }
  context 'Constructing a new instance from a hash' do

    let(:evaluator) { RulesEngine::Evaluator.new(condition: condition, object: 'some object') }

    specify { expect(evaluator.condition).to eq(condition) }
    specify { expect(evaluator.object).to eq('some object') }
  end

  context 'Missing required arguments' do
    context 'condition' do
      specify { expect { RulesEngine::Evaluator.new(object: 'some object') }.to raise_error }
    end
    context 'object' do
      specify { expect { RulesEngine::Evaluator.new(condition: condition) }.to raise_error }
    end
  end
end