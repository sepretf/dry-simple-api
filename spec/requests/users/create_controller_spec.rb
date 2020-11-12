# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::CreateController, type: :request do
  subject(:request) do
    post '/api/v1/users/', headers: headers, params: params.to_json
  end

  let(:headers)   { @headers }

  let(:params) do
    {
      email:      email,
      first_name: first_name,
      last_name:  last_name,
      password:   password
    }
  end

  let(:email)      { 'hello@travel.com' }
  let(:first_name) { 'Foo' }
  let(:last_name)  { 'Bar' }
  let(:password)   { 'FooBar01?' }

  before do
    request
  end

  context 'when params are missing' do
    let(:params) { {} }
    let(:expected_errors) do
      [
        { 'code' => 'users-0001', 'message' => 'Email is missing', 'field_name' => 'email' },
        { 'code' => 'users-0002', 'message' => 'First name is missing', 'field_name' => 'first_name' },
        { 'code' => 'users-0003', 'message' => 'Last name is missing', 'field_name' => 'last_name' },
        { 'code' => 'users-0010', 'message' => 'Password is missing', 'field_name' => 'password' }
      ]
    end

    it 'returns an error' do
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['errors']).to eq(expected_errors)
    end
  end

  context 'with valid params' do
    let(:result) do
      {
        'email'      => email,
        'first_name' => first_name,
        'last_name'  => last_name
      }
    end

    it 'returns the created object' do
      expect(response.status).to eq(201)
      expect(User.first.attributes).to include(result)
      expect(JSON.parse(response.body)['data']['attributes']).to include(result)
    end
  end
end
