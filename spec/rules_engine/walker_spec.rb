require 'spec_helper'

describe 'Walker' do
  let(:ruleset) { RulesEngine::Set.new(root: nil, name: 'some ruleset') }
  let(:rulesets) { Array(ruleset) }
  context 'Constructing a new instance' do
    context 'Accepts a single ruleset' do
      let(:walker) { RulesEngine::Walker.new(set: ruleset, event_logger: nil) }
      specify { expect(walker.sets).to match_array(rulesets) }
    end

    context 'Accepts array of rulesets' do
      let(:walker) { RulesEngine::Walker.new(set: rulesets, event_logger: nil) }
      specify { expect(walker.sets).to match_array(rulesets) }
    end
  end

  context 'Missing required arguments' do
    context 'set' do
      specify { expect { RulesEngine::Walker.new(event_logger: nil) }.to raise_error }
    end
    context 'event_logger' do
      specify { expect { RulesEngine::Walker.new(set: rulesets) }.to raise_error }
    end
  end
end
