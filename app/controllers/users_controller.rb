class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    response = UserCreator.call(@user)
    render json: response
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
