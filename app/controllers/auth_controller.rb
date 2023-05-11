class AuthController < ApplicationController
  def login; end

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

  def auth_params
    params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
  end
end
