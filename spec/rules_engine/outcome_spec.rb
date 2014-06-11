require 'spec_helper'

describe 'Outcome' do

  context 'Constructing a new instance from a hash' do

    let(:outcome) { RulesEngine::Outcome.new(name: 'some outcome', parameter: 'some parameter', reference: 'some reference') }

    specify { expect(outcome.name).to eq('some outcome') }
    specify { expect(outcome.parameter).to eq('some parameter') }
    specify { expect(outcome.reference).to eq('some reference') }
  end

  context 'Missing required arguments' do
    context 'name' do
      specify { expect { RulesEngine::Outcome.new(parameter: 'some parameter', reference: 'some reference') }.to raise_error }
    end
    context 'parameter' do
      specify { expect { RulesEngine::Outcome.new(name: 'some outcome', reference: 'some reference') }.to raise_error }
    end
    context 'reference' do
      specify { expect { RulesEngine::Outcome.new(name: 'some outcome', parameter: 'some parameter') }.to raise_error }
    end
  end
end