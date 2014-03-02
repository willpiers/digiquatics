class StaticPagesController < ApplicationController
  def dashboard
  end

  def about
  end

  def index
    render :index, layout: false
  end

  def chemical_record_stats
    @chemical_records = ChemicalRecord.all
  end

  def user_stats
    @users = User.joins(:account).same_account_as(current_user)
    @location  = Location.all
  end
end
