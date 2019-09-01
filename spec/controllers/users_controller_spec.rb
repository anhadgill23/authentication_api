require 'rails_helper'
require 'faker'
RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'returns a success response' do
        post :create, params: { email: Faker::Internet.email, password: '123123123' }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error response with empty input fields message' do
        post :create, params: {email: Faker::Internet.email}
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Email or password is blank. Please try again.')
      end

      before(:each) do
        @email = Faker::Internet.email
        @password = '123123123'
        post :create, params: { email: @email, password: @password }
      end

      it 'returns an error response with email already taken message' do
        post :create, params: { email: @email, password: @password}
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Email Address is taken. Please try again.')
      end
    end
  end
end
