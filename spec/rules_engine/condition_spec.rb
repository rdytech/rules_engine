require 'spec_helper'

describe RulesEngine::Condition do
  describe '.new' do
    subject { described_class.new(options) }

    context 'where only required arguments are provided' do
      let(:options) do
        {
          name: 'a condition',
          condition: '2 > 1',
        }
      end

      it 'sets name' do
        expect(subject.name).to eq('a condition')
      end

      it 'sets condition' do
        expect(subject.condition).to eq('2 > 1')
      end

      it 'does not set when_true' do
        expect(subject.when_true).to be_nil
      end

      it 'does not set when_false' do
        expect(subject.when_false).to be_nil
      end

      it 'does not set original' do
        expect(subject.original).to be_nil
      end

      it 'does not set override' do
        expect(subject.override).to be_nil
      end

      it 'does not set when_true_outcome' do
        expect(subject.when_true_outcome).to be_nil
      end

      it 'does not set when_false_outcome' do
        expect(subject.when_false_outcome).to be_nil
      end

      it 'does not set when_true_condition' do
        expect(subject.when_true_condition).to be_nil
      end

      it 'does not set when_false_condition' do
        expect(subject.when_false_condition).to be_nil
      end
    end

    context 'where all arguments for single outcome are provided' do
      let(:options) do
        {
          name: 'a condition',
          condition: '2 > 1',
          when_true: true_action,
          when_false: false_action,
        }
      end

      let(:true_action) do
        RulesEngine::Outcome.new(
          name: 'an outcome',
          values: [{ reference: 'true action', parameter: '1' }],
        )
      end

      let(:false_action) do
        RulesEngine::Outcome.new(
          name: 'another outcome',
          values: [{ reference: 'false action', parameter: '1' }],
        )
      end

      it 'sets name' do
        expect(subject.name).to eq('a condition')
      end

      it 'sets condition' do
        expect(subject.condition).to eq('2 > 1')
      end

      it 'sets when_true' do
        expect(subject.when_true).to eq(true_action)
      end

      it 'sets when_false' do
        expect(subject.when_false).to eq(false_action)
      end
    end

    context 'where all arguments for multiple outcome are provided' do
      let(:options) do
        {
          name: 'a condition',
          condition: '2 > 1',
          when_true_outcome: true_outcome,
          when_true_condition: true_condition,
          when_false_outcome: false_outcome,
          when_false_condition: false_condition,
        }
      end

      let(:true_outcome) do
        RulesEngine::Outcome.new(
          name: 'an outcome',
          values: [{ reference: 'true action', parameter: '1' }],
        )
      end

      let(:true_condition) do
        RulesEngine::Condition.new(
          name: 'an condition',
          condition: '2 > 1',
        )
      end

      let(:false_outcome) do
        RulesEngine::Outcome.new(
          name: 'another outcome',
          values: [{ reference: 'false action', parameter: '1' }],
        )
      end

      let(:false_condition) do
        RulesEngine::Condition.new(
          name: 'another condition',
          condition: '2 > 1',
        )
      end

      it 'sets name' do
        expect(subject.name).to eq('a condition')
      end

      it 'sets condition' do
        expect(subject.condition).to eq('2 > 1')
      end

      it 'sets when_true_outcome' do
        expect(subject.when_true_outcome).to eq(true_outcome)
      end

      it 'sets when_false_outcome' do
        expect(subject.when_false_outcome).to eq(false_outcome)
      end

      it 'sets when_true_condition' do
        expect(subject.when_true_condition).to eq(true_condition)
      end

      it 'sets when_false_condition' do
        expect(subject.when_false_condition).to eq(false_condition)
      end
    end

    context 'where name argument is missing' do
      let(:options) do
        {
          condition: '2 > 1',
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end

    context 'where condition argument is missing' do
      let(:options) do
        {
          name: 'a condition',
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end

  describe "#outcome" do
    subject { condition.outcome(which) }

    let(:condition) do
      RulesEngine::Condition.new(
        name: 'an condition',
        condition: '2 > 1',  # irrelevant
        when_true: true_action,
        when_false: false_action,
      )
    end

    let(:true_action) do
      RulesEngine::Outcome.new(
        name: 'an outcome',
        values: [{ reference: 'true action', parameter: '1' }],
      )
    end

    let(:false_action) do
      RulesEngine::Outcome.new(
        name: 'another outcome',
        values: [{ reference: 'false action', parameter: '1' }],
      )
    end

    context "when true" do
      let(:which) { true }

      it "returns true branch" do
        expect(subject).to eq(true_action)
      end
    end

    context "when false" do
      let(:which) { false }

      it "returns false branch" do
        expect(subject).to eq(false_action)
      end
    end
  end

  describe "#outcomes" do
    subject { condition.outcomes(which) }

    let(:condition) do
      RulesEngine::Condition.new(
        name: 'an condition',
        condition: '2 > 1',  # irrelevant
        when_true_outcome: true_outcome,
        when_false_outcome: false_outcome,
        when_true_condition: true_condition,
        when_false_condition: false_condition,
      )
    end

    let(:true_outcome) do
      RulesEngine::Outcome.new(
        name: 'an outcome',
        values: [{ reference: 'true action', parameter: '1' }],
      )
    end

    let(:true_condition) do
      RulesEngine::Condition.new(
        name: 'an condition',
        condition: '2 > 1',
      )
    end

    let(:false_outcome) do
      RulesEngine::Outcome.new(
        name: 'another outcome',
        values: [{ reference: 'false action', parameter: '1' }],
      )
    end

    let(:false_condition) do
      RulesEngine::Condition.new(
        name: 'another condition',
        condition: '2 > 1',
      )
    end

    context "when true" do
      let(:which) { true }

      it "returns true branch" do
        expect(subject).to eq([true_outcome, true_condition])
      end
    end

    context "when false" do
      let(:which) { false }

      it "returns false branch" do
        expect(subject).to eq([false_outcome, false_condition])
      end
    end
  end
end
