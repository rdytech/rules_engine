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
    end

    context 'where all available arguments are provided' do
      let(:options) do
        {
          name: 'a condition',
          condition: '2 > 1',
          when_true: true_action,
          when_false: false_action,
          original: 'original condition',
          override: true,
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

      it 'sets original' do
        expect(subject.original).to eq('original condition')
      end

      it 'sets override' do
        expect(subject.override).to eq(true)
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
end
