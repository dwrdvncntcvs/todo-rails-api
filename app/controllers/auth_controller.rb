require_relative '../helpers/jwt_helper'

class AuthController < ApplicationController
  before_action :validate_user, only: [:login]

  def login
    @user = User.find_by(username: login_params[:username])

    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.jwt_encode({ id: @user.id, username: @user.username })
      render json: { token: }, status: :ok
    else
      render json: { errors: "Invalid Username and Password" }, status: :bad_request
    end
  end

  def register
    @user = User.new(auth_params)

    if @user.save
      render json: { data: @user, message: 'User successfully created' },
             status: :ok
    else
      render json: { errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  private

  def validate_user
    return unless login_params[:username].nil? || login_params[:password].nil?

    render json: { message: 'Invalid Username and Password' },
           status: :bad_request
  end

  def auth_params
    params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
  end

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
