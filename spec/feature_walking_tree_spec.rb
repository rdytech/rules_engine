require "spec_helper"

describe "walking the tree" do
  let(:set) { RulesEngine::Set.new(root, "test") }
  let(:walker) { RulesEngine::Walker.new([set], nil) }

  context "for a tree 1 level deep (only a root action)" do
    let(:root) { RulesEngine::Outcome.new("an action", "1") }

    it "executes the action" do
      walker = RulesEngine::Walker.new([set], nil)

      expect(walker.walk).to eq(set => root)
    end
  end
  
  context "for a tree 2 levels deep" do
    let(:true_action) { RulesEngine::Outcome.new("true action", "1") }
    let(:false_action) { RulesEngine::Outcome.new("false action", "1") }

    context "executes the true action" do
      let(:root) { RulesEngine::Condition.new("2 > 1", true_action, false_action) }

      specify { expect(walker.walk).to eq(set => true_action) }
    end

    context "executes the false action" do
      let(:root) { RulesEngine::Condition.new("2 < 1", true_action, false_action) }

      specify { expect(walker.walk).to eq(set => false_action) }
    end
  end
end
