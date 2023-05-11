require_relative './concerns/jwt_helper'

class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    authorization = request.headers['Authorization']

    if authorization.nil?
      render json: { errors: { message: 'Sign In First!' } },
             status: :unauthorized
      return
    end

    token = authorization.split(' ').last
    data = jwt_decode(token)
    @current_user = User.find_by(data)

    return unless @current_user.nil?

    render json: { errors: { message: 'Sign In First!' } },
           status: :unauthorized
  rescue JWT::VerificationError => e
    render json: { errors: { message: e.message } },
           status: :unauthorized
  end
end
