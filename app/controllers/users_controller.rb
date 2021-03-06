class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_messages]
  skip_before_action :login_verify , only: [:new, :login, :sing_up, :create]
  skip_before_action :chat_users , only: [:new, :login, :sing_up, :create]

  layout 'layouts/login_layout', :only => [:login, :new]

  def send_message
    response = Chat.send_message(params[:chat][:sender_id], params[:chat][:receiver_id], params[:chat][:message])

    respond_to do |format|
      format.json { render :json => response }
    end
  end

  def get_messages
    respond_to do |format|
      format.json { render :json => @user.get_messages }
    end
  end

  def login
    if session[:logged] != nil
      redirect_to "/users/#{session[:logged]["id"]}"
    else
      render "users/login"
    end
  end

  def sing_up
    user = User.login(params[:login][:email], params[:login][:password])
    if user != nil
      session[:logged] = user

      redirect_to "/users/#{user.id}"
    else
      redirect_to "/login"
    end
  end

  def logout
    session[:logged] = nil

    redirect_to "/login"
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:logged] = @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :action => :new, :layout => 'login_layout' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
