require "spec_helper"

describe "walking the tree" do
  let(:event_logger) do
    obj = Object.new
    allow(obj).to receive(:add_event)
    obj
  end

  let(:set) { RulesEngine::Set.new(root, "test") }
  let(:walker) { RulesEngine::Walker.new([set], nil, event_logger) }

  context "for a tree 1 level deep (only a root action)" do
    let(:root) { RulesEngine::Outcome.new("name", "an action", "1") }

    it "executes the action" do
      walker = RulesEngine::Walker.new([set], nil, event_logger)

      expect(walker.walk).to eq(root)
    end
  end
  
  context "for a tree 2 levels deep" do
    let(:true_action) { RulesEngine::Outcome.new("name", "true action", "1") }
    let(:false_action) { RulesEngine::Outcome.new("name", "false action", "1") }

    context "executes the true action" do
      let(:root) { RulesEngine::Condition.new("name", "2 > 1", true_action, false_action) }

      specify { expect(walker.walk).to eq(true_action) }
    end

    context "executes the false action" do
      let(:root) { RulesEngine::Condition.new("name", "2 < 1", true_action, false_action) }

      specify { expect(walker.walk).to eq(false_action) }
    end
  end
end
