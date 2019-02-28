require 'spec_helper'

describe RulesEngine::Outcome do
  describe '.new' do
    subject { described_class.new(options) }

    context 'where only required arguments are provided' do
      let(:options) do
        {
          name: 'an outcome',
          values: [{ parameter: 'some parameter', reference: 'some reference' }],
        }
      end

      it 'sets name' do
        expect(subject.name).to eq('an outcome')
      end

      it 'sets values' do
        expect(subject.values).to eq([{ parameter: 'some parameter', reference: 'some reference' }])
      end

      it 'does not set reference' do
        expect(subject.reference).to be_nil
      end

      it 'does not set original' do
        expect(subject.original).to be_nil
      end
    end

    context 'where all available arguments are provided' do
      let(:options) do
        {
          name: 'an outcome',
          values: [{ parameter: 'some parameter', reference: 'some reference' }],
          reference: 'outcome_reference',
          original: 'original outcome',
        }
      end

      it 'sets name' do
        expect(subject.name).to eq('an outcome')
      end

      it 'sets values' do
        expect(subject.values).to eq([{ parameter: 'some parameter', reference: 'some reference' }])
      end

      it 'sets reference' do
        expect(subject.reference).to eq('outcome_reference')
      end

      it 'sets original' do
        expect(subject.original).to eq('original outcome')
      end
    end

    context 'where name argument is missing' do
      let(:options) do
        {
          values: [{ parameter: 'some parameter', reference: 'some reference' }],
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end

    context 'where values argument is missing' do
      let(:options) do
        {
          name: 'an outcome',
        }
      end

      specify do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end
end
