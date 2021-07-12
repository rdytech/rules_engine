require 'spec_helper'

describe RulesEngine::Set do
  describe '.new' do
    subject { described_class.new(options) }

    let(:root_condition) do
      RulesEngine::Condition.new(
        name: 'a condition',
        condition: '2 > 1',
      )
    end

    context 'where only required arguments are provided' do
      let(:options) do
        {
          name: 'a rule set',
          root: root_condition,
        }
      end

      it 'sets name' do
        expect(subject.name).to eq('a rule set')
      end

      it 'sets root' do
        expect(subject.root).to eq(root_condition)
      end

      it 'does not set original' do
        expect(subject.original).to be_nil
      end

      it "defaults to single outcome" do
        expect(subject).to_not be_multiple_outcomes
      end
    end

    context 'where all available arguments are provided' do
      let(:options) do
        {
          name: 'a rule set',
          root: root_condition,
          original: 'original rule set',
          multiple_outcomes: true,
        }
      end

      it 'sets name' do
        expect(subject.name).to eq('a rule set')
      end

      it 'sets root' do
        expect(subject.root).to eq(root_condition)
      end

      it 'sets original' do
        expect(subject.original).to eq('original rule set')
      end

      it "sets as single or multiple outcome" do
        expect(subject).to be_multiple_outcomes
      end
    end

    context 'where name argument is missing' do
      let(:options) do
        {
          root: root_condition,
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end

    context 'where root argument is missing' do
      let(:options) do
        {
          name: 'a rule set',
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end

  describe "#multiple_outcomes?" do
    subject { set.multiple_outcomes? }

    let(:set) { RulesEngine::Set.new(root: root, name: "Set", multiple_outcomes: multiple_outcomes) }
    let(:root) { RulesEngine::Condition.new(name: "Root", condition: "1 == 1") }

    context "when @multiple_outcomes is true" do
      let(:multiple_outcomes) { true }
      specify { expect(subject).to be_truthy }
    end

    context "when @multiple_outcomes is false" do
      let(:multiple_outcomes) { false }
      specify { expect(subject).to be_falsey }
    end
  end
end
