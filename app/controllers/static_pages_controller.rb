class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @male_users = User.all.where(sex: 'M')
    @female_users = User.all.where(sex: 'F')
  end

  def about
  end

  def positions
  end

  def lessons
  end

  def chemicals
  end

  def manage_chemicals
  end
end
