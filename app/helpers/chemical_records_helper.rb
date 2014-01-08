module ChemicalRecordsHelper
	include Math
	
	#SI Index equation
	def si_index(ph_reading, pool_temp, calcium_hardness, total_alkalinity)
	  if (!ph_reading or !pool_temp or !calcium_hardness or !total_alkalinity)
	    '?'
	  else
	    ph = ph_reading
	    temp = ((0.7571*log(pool_temp))-2.6639)
	    ch = ((0.4341*log(calcium_hardness))-0.3926)
	    ta = ((0.4341*log(total_alkalinity))+0.0074)
	    tds = 12.1
	    si = (ph + temp + ch + ta - tds)
	  end
	end

	#SI Description
	def si_index_description(si_index)
	  if !si_index
	    '?'
	  elsif si_index < -0.3
	    "Corrosion"
	  elsif si_index > 0.3 
	    "Scale Forming"
	  elsif si_index >= -0.3 and si_index <= 0.3
	    "Balanced"       
	  else
	    "Error"
	  end
	end
end
