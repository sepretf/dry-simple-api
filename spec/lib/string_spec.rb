# frozen_string_literal: true

RSpec.describe String do
  describe '#slugify' do
    subject { str.slugify }

    context 'with special characters' do
      let(:str) { 'test à User &' }

      it { is_expected.to eq('test_a_user') }
    end

    context 'with dash' do
      let(:str) { 'foo - Bar' }

      it { is_expected.to eq('foo_bar') }
    end
  end

  describe '#trim' do
    subject { str.trim }

    context 'with empty string' do
      let(:str) { '  ' }

      it { is_expected.to eq('') }
    end

    context 'with trailing spaces' do
      let(:str) { '  foo  -   bar    ' }

      it { is_expected.to eq('foo  -   bar') }
    end
  end
end
