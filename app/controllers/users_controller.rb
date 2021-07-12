class UsersController < ApplicationController
  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      render json: {username: @user.username, email: @user.email, profile_pic: @user.profile_pic.service_url, token: encode({user_id: @user.id})}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      render json: { username: @user.username, email: @user.email, profile_pic: @user.profile_pic.service_url, token: encode({ user_id: @user.id }) }, status: :ok
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :profile_pic)
  end
end
