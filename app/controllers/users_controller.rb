class UsersController < ApplicationController
  def create
    # change this to search for redis
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: {
        status: 200,
        user: user
      }
    else
      # enter proper error messages
      render json: {
        status: 'error',
        code: 401
      }
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
