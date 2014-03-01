module ChemicalRecordsHelper
  include Math

  SI_CALC_RANGES = {
    [-100, -5] => {
      status: 'Severe Corrosion',
      recommendation: 'Treatment Recommended'
    },
    [-4.99, -2] => {
      status: 'Moderate Corrosion',
      recommendation: 'Treatment May Be Needed'
    },
    [-1.99, -0.5] => {
      status: 'Mild Corrosion',
      recommendation: 'Treatment May Be Needed'
    },
    [-0.49, -0.31] => {
      status: 'Possible Mild Corrosion',
      recommendation: 'Probably No Treatment'
    },
    [-0.3, 0.3] => {
      status: 'Balanced',
      recommendation: 'No Treatment'
    },
    [0.31, 0.5] => {
      status: 'Some Faint Coating',
      recommendation: 'Probably No Treatment'
    },
    [0.51, 1] => {
      status: 'Mild Scale Coating',
      recommendation: 'Treatment May Be Needed'
    },
    [1.01, 2] => {
      status: 'Mild to Moderate Coatings',
      recommendation: 'Treatment May Be Needed'
    },
    [2.01, 3] => {
      status: 'Moderate Scale Forming',
      recommendation: 'Treatment Recommended'
    },
    [3.01, 100] => {
      status: 'Severe Scale Forming',
      recommendation: 'Treatment Recommended'
    }
  }

  def si_index_calculator(ph_reading, pool_temp, calcium_hardness, alkalinity)
    temp = 0.7571 * log(pool_temp) - 2.6639
    ch   = 0.4341 * log(calcium_hardness) - 0.3926
    ta   = 0.4341 * log(alkalinity) + 0.0074
    @si  = ph_reading + temp + ch + ta - 12.1
  end

  def si_calc(si_index, option)
    SI_CALC_RANGES.each do |range, message|
      return message[option] if si_index.between?(*range)
    end
  end
end
