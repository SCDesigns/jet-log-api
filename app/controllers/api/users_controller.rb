class Api::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'users/user_with_token.json.jbuilder', user: @user
    else
      render json: {
        errors: {
          message: "Unable to create user. E-Mail Address already taken or is not valid"
        }
      }
    end
  end

  private
    def user_params
      params.require(:log).permit(:name, :email, :password, :password_confirmation)
    end
end
