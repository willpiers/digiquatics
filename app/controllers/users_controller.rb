class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end
  
	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	sign_in @user
    	flash[:success] = "This account has been successfully created!"
    	redirect_to @user
    else
      render 'new'
    end
  end


private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation, :date_of_birth, :date_of_hire, :sex, :phone_number, :shirt_size, :suit_size)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
end
