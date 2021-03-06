class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    permitted = %i[name email password password_confirmation]
    params.require(:user).permit permitted
  end
end
