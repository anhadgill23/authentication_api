class SessionsController < ApplicationController
  def create
    # change this to search for redis instead
    user = User
           .find_by(email: params[:email])
           .try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      render json: {
        # maybe change this to 200?
        status: 'ok',
        code: 200,
        user: user
      }
    else
      render json: { status: 401 }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sign_in'
  end
end
