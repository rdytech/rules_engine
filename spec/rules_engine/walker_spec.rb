require 'spec_helper'

describe 'Walker' do
  let(:ruleset) { RulesEngine::Set.new(nil, 'some ruleset') }
  let(:rulesets) { Array(ruleset) }
  context 'Constructing a new instance' do
    context 'Accepts a single ruleset' do
      let (:walker) { RulesEngine::Walker.new(ruleset, nil, nil) }
      specify { expect(walker.sets).to match_array(rulesets) }
    end

    context 'Accepts array of rulesets' do
      let (:walker) { RulesEngine::Walker.new(rulesets, nil, nil) }
      specify { expect(walker.sets).to match_array(rulesets) }
    end
  end
end
