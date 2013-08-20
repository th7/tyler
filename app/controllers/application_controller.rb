class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= authorize_user
  end

  def authorize_user
    user = User.where(username: params[:user][:username]).first
    if user.password == params[:user][:password]
      user
    else
      nil
    end
  end
end
