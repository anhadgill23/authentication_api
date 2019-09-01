require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:all) do
    @email = Faker::Internet.email
    @password = BCrypt::Password.create('123123123')
    key = "user:#{@email}"
    Rdb.hash_m_set key, 'email', @email, 'password', @password
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'returns a success response' do
        post :create, params: { email: @email, password: @password }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error response with empty input fields message' do
        post :create, params: { email: Faker::Internet.email }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Email or password is blank. Please try again.')
      end

      it 'returns an error response with wrong password message' do
        post :create, params: { email: @email, password: '123098765' }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Incorrect username/password. Please try again.')
      end
    end
  end
end
