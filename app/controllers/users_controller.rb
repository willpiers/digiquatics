class UsersController < ApplicationController
  
	def show
		@user = User.find(params[:id])
	end

  	def new
  		@user = User.new
  	end

  def create
    @user = User.new(user_params)
    if @user.save
    	flash[:success] = "This account has been successfully created!"
    	redirect_to @user
    else
      render 'new'
    end
  end
def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation, :date_of_birth, :date_of_hire, :sex, :phone_number, :shirt_size, :suit_size)
    end
end
