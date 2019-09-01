class SessionsController < ApplicationController
  def create
    response = Authenticator.call(user_params)

    if response[:status] == :ok
      render json: response, status: :ok
    else
      render json: response, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
