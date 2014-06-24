require 'spec_helper'

describe 'Set' do
  let(:condition) { RulesEngine::Condition.new(name: 'name', condition: '2 > 1') }
  context 'Constructing a new instance from a hash' do

    let(:ruleset) { RulesEngine::Set.new(name: 'some set', root: condition) }

    specify { expect(ruleset.name).to eq('some set') }
    specify { expect(ruleset.root).to eq(condition) }
  end

  context 'Missing required arguments' do
    context 'name' do
      specify { expect { RulesEngine::Set.new(root: condition) }.to raise_error }
    end
    context 'root' do
      specify { expect { RulesEngine::Set.new(name: 'some set') }.to raise_error }
    end
  end
end