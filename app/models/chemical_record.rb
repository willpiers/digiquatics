class ChemicalRecord < ActiveRecord::Base
  belongs_to :pool
  belongs_to :location
  belongs_to :user

  validates_presence_of :time_stamp, :user_id, :pool_id, :total_chlorine_ppm,
                        :ph

  comma do
    location name: 'Location'
    pool name: 'Pool'
    free_chlorine_ppm 'Free Cl'
    combined_chlorine_ppm 'Combined Cl'
    total_chlorine_ppm ' Total Cl'
    ph 'PH'
    alkalinity ' Alk'
    calcium_hardness 'CH'
    pool_temp 'Pool(F)'
    air_temp 'Air(F)'
    water_clarity 'Clarity'
    si_index 'SI'
    si_status 'SI Status'
    si_recommendation 'SI Recommendation'
    user last_name: 'Last Name'
    user first_name: 'First Name'
    user phone_number: 'Phone #'
    time_stamp 'Date Submitted'
  end

  def self.same_account_as(user)
    where(pool_id:
      user.account.locations.map(&:pools).reject(&:empty?).flatten.map(&:id))
  end
end

