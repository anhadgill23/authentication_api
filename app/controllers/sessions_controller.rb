class SessionsController < ApplicationController
  def create
    debugger
    response = Authenticator.call(user_params)
    render json: response
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
