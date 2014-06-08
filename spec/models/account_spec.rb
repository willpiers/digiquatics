require 'spec_helper'

describe Account do
  before do
    @account = Account.new(name: 'City of Lakewood',
                           time_zone: 'Mountain Time (US & Canada)',
                           slides_group_email:              false,
                           slides_admin_email:              false,
                           slides_location_email:           false,
                           maintenance_group_email:         false,
                           maintenance_admin_email:         false,
                           maintenance_location_email:      false,
                           chemical_records_group_email:    false,
                           chemical_records_admin_email:    false,
                           chemical_records_location_email: false)
  end

  subject { @account }

  it { should respond_to :name }
  it { should respond_to :time_zone }
  it { should respond_to(:logo) }
  it { should respond_to(:slides_group_email) }
  it { should respond_to(:slides_admin_email) }
  it { should respond_to(:slides_location_email) }
  it { should respond_to(:maintenance_group_email) }
  it { should respond_to(:maintenance_admin_email) }
  it { should respond_to(:maintenance_location_email) }
  it { should respond_to(:chemical_records_group_email) }
  it { should respond_to(:chemical_records_admin_email) }
  it { should respond_to(:chemical_records_location_email) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @account.name = nil }
    it { should_not be_valid }
  end
end
