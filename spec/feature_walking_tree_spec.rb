require "spec_helper"

describe "walking the tree" do

  context "for a tree 1 level deep (only a root action)" do
    it "executes the action" do
      tree = RulesEngine::Action.new("an action")
      walker = RulesEngine::Walker.new(tree, nil)

      expect(walker.walk).to eq("executing: an action")
    end
  end
  
  context "for a tree 2 levels deep" do
    it "executes the true action" do
      true_action = RulesEngine::Action.new("true action")
      false_action = RulesEngine::Action.new("false action")
      tree = RulesEngine::Condition.new("2 > 1", true_action, false_action)
      walker = RulesEngine::Walker.new(tree, nil)

      expect(walker.walk).to eq("executing: true action")
    end

    it "executes the false action" do
      true_action = RulesEngine::Action.new("true action")
      false_action = RulesEngine::Action.new("false action")
      tree = RulesEngine::Condition.new("2 < 1", true_action, false_action)
      walker = RulesEngine::Walker.new(tree, nil)

      expect(walker.walk).to eq("executing: false action")
    end
  end

end
