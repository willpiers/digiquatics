class ChemicalRecord < ActiveRecord::Base
  extend ScopeHelper
  pool_scopes

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
end
