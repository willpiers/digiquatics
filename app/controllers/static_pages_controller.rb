class StaticPagesController < ApplicationController
  def home
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

  def certifications_stats
  end

  def user_stats
    @users = User.all
    @male_users = User.all.where(sex: 'M')
    @female_users = User.all.where(sex: 'F')
    @active = User.all.where(active: true)
    @inactive = User.all.where(active: false)
    @admin_true = User.all.where(admin: true)
  end

end
