class UsersController < ApplicationController
  
	def show
		@user = User.find(params[:id])
	end

  	def new
  		@user = User.new
  	end

  def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end
def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation, :date_of_birth, :date_of_hire, :sex, :phone_number, :shirt_size, :suit_size)
    end
end
