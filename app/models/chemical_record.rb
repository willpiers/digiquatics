class ChemicalRecord < ActiveRecord::Base

	# ===============
	# = CSV support =
	# ===============
	comma do  # implicitly named :default
		chlorine_ppm
		ph               
		alkalinity       
		calcium_hardness 
		pool_temp        
		air_temp              
		date_time_reading
	end
end
