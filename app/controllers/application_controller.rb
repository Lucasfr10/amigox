class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :login_verify
  before_action :chat_users, :except => [:login_verify, :login, :sing_in]

  def login_verify
    if !session[:logged]
      redirect_to "/login"
    end
  end

  def chat_users
    @chat_users = User.where.not(:id => session[:logged]["id"])
  end
end
