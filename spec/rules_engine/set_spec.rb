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
    end

    context 'where all available arguments are provided' do
      let(:options) do
        {
          name: 'a rule set',
          root: root_condition,
          original: 'original rule set',
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
end
