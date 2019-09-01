require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    @email = Faker::Internet.email
    @password = '123123123'
    params = {
      email: @email,
      password: @password,
    }
    debugger
    post sign_up_path
  end
  describe 'POST #create' do

    context 'with valid attributes' do
      it 'returns a success response' do

        post '/sign_up', params
        post :create, params: { email: email, password: '123123123' }
        post
      end
    end

    context 'with invalid attributes' do
      it 'returns an error response with empty input fields message'
      it 'returns an error response with wrong password message'
    end
  end
end
