module ChemicalRecordsHelper
  include Math

  # rubocop : disable all
  def si_index_calculator(ph_reading, pool_temp, calcium_hardness, total_alkalinity)
    if !ph_reading || !pool_temp || !calcium_hardness || !total_alkalinity
      '?'
    else
      ph = ph_reading
      temp = ((0.7571 * log(pool_temp)) - 2.6639)
      ch = ((0.4341 * log(calcium_hardness)) - 0.3926)
      ta = ((0.4341 * log(total_alkalinity)) + 0.0074)
      tds = 12.1
      @si = (ph + temp + ch + ta - tds)
    end
  end

  def si_status_calc(si_index)
    if !si_index
      '?'
    elsif si_index <= -5
      'Severe Corrosion'
    elsif si_index > -5 && si_index <= -3
      'Moderate Corrosion'
    elsif si_index > -3 && si_index <= -2
      'Moderate Corrosion'
    elsif si_index > -2 && si_index <= -1
      'Mild Corrosion'
    elsif si_index > -1 && si_index <= -0.5
      'None-Mild Corrosion'
    elsif si_index > -0.5 && si_index < -0.3
      'Mild Corrosion '
    elsif si_index >= -0.3 && si_index <= 0.3
      'Balanced'
    elsif si_index > 0.3 && si_index <= 0.5
      'Some Faint Coating'
    elsif si_index > 0.5 && si_index <= 1
      'Mild Scale Coating'
    elsif si_index > 1 && si_index <= 2
      'Mild to Moderate Coatings'
    elsif si_index > 2 && si_index <= 3
      'Moderate Scale Forming'
    elsif si_index > 3
      'Severe Scale Forming'
    else
      'Error'
    end
  end

  def si_recommendation_calc(si_index)
    if !si_index
      '?'
    elsif si_index <= -5
      'Treatment Recommended'
    elsif si_index > -5 && si_index <= -3
      'Treatment Recommended'
    elsif si_index > -3 && si_index <= -2
      'Treatment May Be Needed'
    elsif si_index > -2 && si_index <= -1
      'Treatment May Be Needed'
    elsif si_index > -1 && si_index <= -0.5
      'Probably No Treatment'
    elsif si_index > -0.5 && si_index < -0.3
      'Probably No Treatment '
    elsif si_index >= -0.3 && si_index <= 0.3
      'No Treatment'
    elsif si_index > 0.3 && si_index <= 0.5
      'Probably No Treatment'
    elsif si_index > 0.5 && si_index <= 1
      'Treatment May Be Needed'
    elsif si_index > 1 && si_index <= 2
      'Treatment May Be Needed'
    elsif si_index > 2 && si_index <= 3
      'Treatment Recommended'
    elsif si_index > 3
      'Treatment Recommended'
    else
      'Error'
    end
  end

  # rubocop : enable all

end
