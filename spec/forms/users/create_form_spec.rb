# frozen_string_literal: true

RSpec.describe Users::CreateForm, type: :form do
  subject(:form) { instance.call(params: params) }

  before { DatabaseCleaner.start }

  let(:instance) { described_class.new }
  let(:params) do
    {
      email:      email,
      first_name: first_name,
      last_name:  last_name,
      password:   password
    }
  end

  let(:email)      { 'test@dry.co' }
  let(:first_name) { 'Foo' }
  let(:last_name)  { 'Bar' }
  let(:password)   { 'passworD1!' }

  context 'with invalid email' do
    let(:email) { 'f' }

    it { expect(form.failure).to eq({ email: ['is in invalid format'] }) }
  end

  context 'with invalid password' do
    let(:password) { 'f' }

    it { expect(form.failure).to eq({ password: ['is in invalid format'] }) }
  end

  context 'with email already used' do
    before do
      FactoryBot.create(:user, email: email)
    end

    it { expect(form.failure).to eq({ email: ['must be uniq'] }) }
  end

  context 'with successful validation' do
    let(:expected_ouput) do
      {
          'email'      => email,
          'first_name' => first_name,
          'last_name'  => last_name
      }
    end

    it 'creates the consent' do
      form

      expect(User.first.attributes).to include(expected_ouput)
    end
  end
end
