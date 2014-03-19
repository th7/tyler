class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= authorized_user
  end

  def authorized_user
    user if username && password && user && user.password == password
  end

  def param_user
    params[:user] || {}
  end

  def username
    param_user[:username]
  end

  def password
    param_user[:password]
  end

  def user
    @user ||= User.where(username: username).first
  end

  def check_auth
    render :status => :bad_request, :text => '' unless current_user
  end
end
