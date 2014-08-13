require 'spec_helper'

describe 'Outcome' do

  context 'Constructing a new instance from a hash' do

    let(:outcome) { RulesEngine::Outcome.new(name: 'some outcome', values: [{ parameter: 'some parameter', reference: 'some reference' }]) }

    specify { expect(outcome.name).to eq('some outcome') }
    specify { expect(outcome.values.first[:parameter]).to eq('some parameter') }
    specify { expect(outcome.values.first[:reference]).to eq('some reference') }
  end

  context 'Missing required arguments' do
    context 'name' do
      specify { expect { RulesEngine::Outcome.new(values: [{ parameter: 'some parameter', reference: 'some reference' }]) }.to raise_error }
    end
    context 'values' do
      specify { expect { RulesEngine::Outcome.new(name: 'some outcome') }.to raise_error }
    end
  end
end