# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../helpers/authorization_helper'

RSpec.describe API::V1::Users::Login::ShowController, type: :request do
  include AuthorizationHelper

  subject(:request) do
    get '/api/v1/users/login/auto_login', headers: headers
  end

  let(:headers) { @headers.merge({ 'Authorization' => "Bearer #{encode_token(user)}" }) }

  let(:email)      { 'hello@travel.com' }
  let(:first_name) { 'Foo' }
  let(:last_name)  { 'Bar' }
  let(:password)   { 'FooBar01?' }
  let(:user)       do
    FactoryBot.create(:user, email: email, first_name: first_name, last_name: last_name, password: password)
  end

  before do
    request
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
      expect(response.status).to eq(200)
      expect(User.first.attributes).to include(result)
      expect(JSON.parse(response.body)['data']['attributes']).to include(result)
    end
  end
end
