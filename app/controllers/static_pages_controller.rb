class StaticPagesController < ApplicationController

  def home
  end

  def about
  end

  def certifications_stats
    @users = User.all
    @certification_names = CertificationName.joins(:account)
      .where(account_id: current_user.account_id)
    @Certification_Count = Certification.joins(:user)
      .where("expiration_date >=?", 30.days.ago.to_date)
      .group(:certification_id)
  end

  def user_stats
    @users = User.all
    @male_users = User.all.where(sex: 'M')
    @female_users = User.all.where(sex: 'F')
    @active = User.all.where(active: true)
    @inactive = User.all.where(active: false)
    @admin_true = User.all.where(admin: true)
    @location = Location.all
  end
end
