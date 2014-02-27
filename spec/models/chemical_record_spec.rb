require 'spec_helper'

describe ChemicalRecord do

  before do
    @chemical_record = ChemicalRecord.new(
      chlorine_ppm:      5,
      chlorine_orp:      550,
      ph:                8.0,
      alkalinity:        120,
      calcium_hardness:  200,
      pool_temp:         98,
      air_temp:          95,
      si_index:          -2.5,
      time_stamp:        '2010-10-10 16:19:00 UTC',
      si_status:         'Balanced',
      si_recommendation: 'Nothing needed',
      user_id:            1,
      pool_id:            1)
  end

  subject { @chemical_record }

  it { should respond_to(:chlorine_ppm) }
  it { should respond_to(:chlorine_orp) }
  it { should respond_to(:ph) }
  it { should respond_to(:alkalinity) }
  it { should respond_to(:calcium_hardness) }
  it { should respond_to(:pool_temp) }
  it { should respond_to(:air_temp) }
  it { should respond_to(:si_index) }
  it { should respond_to(:time_stamp) }
  it { should respond_to(:si_status) }
  it { should respond_to(:si_recommendation) }
  it { should respond_to(:user_id) }
  it { should respond_to(:pool_id) }

  it { should be_valid }

  describe 'when time_stamp is not present' do
    before { @chemical_record.time_stamp = nil }
    it { should_not be_valid }
  end

  describe 'when user_id is not present' do
    before { @chemical_record.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when pool_id is not present' do
    before { @chemical_record.pool_id = nil }
    it { should_not be_valid }
  end
end
