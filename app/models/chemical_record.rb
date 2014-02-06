class ChemicalRecord < ActiveRecord::Base
  comma do
    chlorine_ppm
    ph
    alkalinity
    calcium_hardness
    pool_temp
    air_temp
    si_index
    date_stamp
    time_stamp
  end
end
