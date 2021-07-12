require "spec_helper"

describe RulesEngine::Walker do
  let(:walker) { described_class.new(args) }
  let(:args) { { set: set, event_logger: nil } }
  let(:set) { rule_set }
  let(:rule_set) { RulesEngine::Set.new(name: "Rule Set", root: nil) }

  describe "required arguments" do
    subject { walker }

    context "missing set" do
      let(:args) { { event_logger: nil } }

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end

    context "missing event_logger" do
      let(:args) { { set: set } }

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end

  describe "#sets" do
    subject { walker.sets }

    context "when single rule set supplied" do
      let(:set) { rule_set }

      it "is array of that single rule set" do
        expect(subject).to match_array([rule_set])
      end
    end

    context "when array of rule sets supplied" do
      let(:set) { Array(rule_set) }

      it "is that array of rule sets" do
        expect(subject).to match_array([rule_set])
      end
    end
  end

  describe "#walk" do
    subject { walker.walk }

    let(:rule_set) { RulesEngine::Set.new(name: "Rule Set", root: root) }
    let(:root) { rc_1 }

    context "single rule set with no outcome" do
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: nil) }

      it { is_expected.to be_nil }
    end

    context "single rule set with one outcome" do
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: ro_1) }
      let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }

      it { is_expected.to eq(ro_1) }
    end

    # NOTE: it seems weird that it only returns one outcome for a collection of rule sets
    context "multiple rule sets with one outcome each" do
      let(:set) { [rs_1, rs_2] }
      let(:rs_1) { RulesEngine::Set.new(name: "Rule Set 1", root: root_1) }
      let(:rs_2) { RulesEngine::Set.new(name: "Rule Set 2", root: root_2) }
      let(:root_1) { rc_root_1 }
      let(:root_2) { rc_root_2 }

      let(:rc_root_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: ro_1) }
      let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }

      let(:rc_root_2) { RulesEngine::Condition.new(name: "Rule Condition 2", condition: "1 == 1", when_true: ro_2) }
      let(:ro_2) { RulesEngine::Outcome.new(name: "Rule Outcome 2", values: "Outcome 2 Values") }

      it { is_expected.to eq(ro_1) }
    end
  end

  describe "#walk_set" do
    subject { walker.walk_set(set) }

    let(:rule_set) { RulesEngine::Set.new(name: "Rule Set", root: root, multiple_outcomes: multiple_outcomes) }
    let(:multiple_outcomes) { false }
    let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1") }

    context "no root" do
      let(:root) { nil }
      it { is_expected.to be_nil }
    end

    context "root without true/false branches" do
      let(:root) { rc_1 }
      it { is_expected.to be_nil }
    end

    context "root with rule outcome on true branch" do
      let(:root) { rc_1 }
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: ro_1) }
      let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }

      it { is_expected.to eq(ro_1) }
    end

    context "root with rule outcome on false branch" do
      let(:root) { rc_1 }
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 != 1", when_false: ro_1) }
      let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }

      it { is_expected.to eq(ro_1) }
    end

    context "root with multiple conditions but no rule outcome" do
      let(:root) { rc_1 }
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: rc_2) }
      let(:rc_2) { RulesEngine::Condition.new(name: "Rule Condition 2", condition: "1 == 1") }

      it { is_expected.to be_nil }
    end

    context "root with multiple conditions and rule outcome" do
      let(:root) { rc_1 }
      let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true: rc_2) }
      let(:rc_2) { RulesEngine::Condition.new(name: "Rule Condition 2", condition: "1 == 1", when_true: ro_1, when_false: ro_2) }
      let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }
      let(:ro_2) { RulesEngine::Outcome.new(name: "Rule Outcome 2", values: "Outcome 2 Values") }

      it { is_expected.to eq(ro_1) }
    end

    context "for multiple outcomes" do
      let(:multiple_outcomes) { true }

      context "no root" do
        let(:root) { nil }
        it { is_expected.to eq([]) }
      end

      context "root with multiple conditions and rule outcome" do
        let(:root) { rc_1 }
        let(:rc_1) { RulesEngine::Condition.new(name: "Rule Condition 1", condition: "1 == 1", when_true_outcome: ro_1, when_true_condition: rc_2) }
        let(:rc_2) { RulesEngine::Condition.new(name: "Rule Condition 2", condition: "1 == 1", when_true_outcome: ro_2, when_true_condition: rc_3) }
        let(:rc_3) { RulesEngine::Condition.new(name: "Rule Condition 3", condition: "1 != 1", when_true_outcome: ro_3, when_false_condition: rc_4) }
        let(:rc_4) { RulesEngine::Condition.new(name: "Rule Condition 4", condition: "1 == 1", when_true_outcome: ro_4) }
        let(:ro_1) { RulesEngine::Outcome.new(name: "Rule Outcome 1", values: "Outcome 1 Values") }
        let(:ro_2) { RulesEngine::Outcome.new(name: "Rule Outcome 2", values: "Outcome 2 Values") }
        let(:ro_3) { RulesEngine::Outcome.new(name: "Rule Outcome 3", values: "Outcome 3 Values") }
        let(:ro_4) { RulesEngine::Outcome.new(name: "Rule Outcome 4", values: "Outcome 3 Values") }

        it { is_expected.to eq([ro_1, ro_2, ro_4]) }
      end
    end
  end
end
