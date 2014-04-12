class ChemicalRecord < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  validates_presence_of :time_stamp, :user_id, :pool_id, :total_chlorine_ppm,
                        :ph

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
    time_stamp
  end

  def self.same_account_as(user)
    where(pool_id:
      user.account.locations.map(&:pools).reject(&:empty?).flatten.map(&:id))
  end
end
