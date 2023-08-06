class RegistrationsController < ApplicationController
  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_login_path
    else
      flash[:alert] = "Couldn't save the User!"
      render :new, status: :unprocessable_entity
    end
  end


  private 
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
