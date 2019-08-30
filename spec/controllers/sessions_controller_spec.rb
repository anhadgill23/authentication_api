require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'returns a success response'
    end

    context 'with invalid attributes' do
      it 'returns an error response with empty input fields message'
      it 'returns an error response with wrong password message'
    end
  end
end
