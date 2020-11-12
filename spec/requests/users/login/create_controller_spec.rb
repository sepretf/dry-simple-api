# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Login::CreateController, type: :request do
  subject(:request) do
    post '/api/v1/users/login', headers: headers, params: params.to_json
  end

  let(:headers)   { @headers }

  let(:params) do
    {
      email:    email,
      password: password
    }
  end

  let(:email)      { 'hello@travel.com' }
  let(:password)   { 'FooBar01?' }

  context 'when params are missing' do
    before { request }

    let(:params) { {} }
    let(:expected_errors) do
      [
        {
          'code'       => 'request-0001',
          'field_name' => 'request',
          'message'    => 'Request invalid arguments'
        }
      ]
    end

    it 'returns an error' do
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['errors']).to eq(expected_errors)
    end
  end

  context 'with valid params' do
    before do
      FactoryBot.create(:user, email: email, password: password, first_name: 'test', last_name: 'Bar')

      request
    end

    let(:result) do
      {
        'email'      => email,
        'first_name' => 'test',
        'last_name'  => 'Bar'
      }
    end

    it 'returns the created object' do
      expect(response.status).to eq(200)
      expect(User.first.attributes).to include(result)
      expect(JSON.parse(response.body)['data']['attributes']).to include(result)
    end
  end
end
