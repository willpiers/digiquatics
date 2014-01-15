class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def chemical_record_stats
    @chemical_records = ChemicalRecord.all
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
