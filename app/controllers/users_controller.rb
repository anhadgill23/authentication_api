class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    response = UserCreator.call(@user)

    if response[:status] == :ok
      render json: response, status: :created
    else
      render json: response, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
