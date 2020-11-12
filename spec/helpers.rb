# frozen_string_literal: true

# Collection of helpers to facilitate testing
# They are available in all of your tests
module Helpers
  # Returns parsed errors present in JSON response without message
  # Can be tested like so :
  #
  # let(:errors) do
  #   [
  #     {
  #       'code'       => 'contacts-001',
  #       'field_name' => 'field_1'
  #     },
  #     {
  #       'code'       => 'contacts-002',
  #       'field_name' => 'field_2'
  #     },
  #   ]
  # end
  #
  # it 'returns an error' do
  #   expect(response.status).to eq(400)
  #   expect(testable_errors(response)).to match_array(errors)
  # end
  #
  def testable_errors(response)
    testable_response(response)['errors'].each { |error| error.delete('message') }
  end

  # Shortcut to return JSON parsed response directly
  #
  def testable_response(response)
    JSON.parse(response.body)
  end

  # Shortcut to return JSON parsed response data attributes directly
  #
  def testable_response_attributes(response)
    testable_response(response)['data']['attributes']
  end
end
