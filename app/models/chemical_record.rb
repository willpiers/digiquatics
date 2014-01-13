class ChemicalRecord < ActiveRecord::Base
  comma do
    chlorine_ppm
    ph
    alkalinity
    calcium_hardness
    pool_temp
    air_temp
    date_time_reading
  end
end
