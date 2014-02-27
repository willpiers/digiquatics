class ChemicalRecord < ActiveRecord::Base
  belongs_to :pool

  validates_presence_of :date_stamp, :time_stamp, :user_id, :pool_id

  comma do
    chlorine_ppm
    ph
    alkalinity
    calcium_hardness
    pool_temp
    air_temp
    si_index
    si_status
    si_recommendation
    date_stamp
    time_stamp
  end

  def self.same_account_as(user)
    where(pool_id:
      user.account.locations.map(&:pools).reject(&:empty?).flatten.map(&:id))
  end
end
