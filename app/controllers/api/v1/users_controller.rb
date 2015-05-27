module Api
  module V1
    class UsersController < ApplicationController

      #force authentication for all of the following actions
      before_filter :authenticate, only: [:index]

      def sign_in
        #search the users table for the email that the user passed in
        user = User.find_by(email: params[:email])

        #this authenticate method below is from the has_secure_passord method from user.rb
        #if user exists & authenticates, then return them a token
        if user && user.authenticate(params[:password])
          render json: { token: user.token }
        else
          head :unauthorized
        end
      end

      def index
        render json: User.all, status: :ok
      end

      def show
        @user - User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { token: @user.token }
        else
          render json: { message: 'failed', status: 500 }
        end
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :token)
      end

    end
  end
end
