require 'spec_helper'

describe HelpDesk do

  before do
    @help_desk = HelpDesk.new(
      name: 'Broken Pipe',
      urgency: 'High',
      user_id: 1,
      location_id: 1,
      description: 'it sucks badly',
      issue_status: true,
      issue_resolution_description: 'completed',
      closed_user_id: 2,
      closed_date_time: '2010-10-10 16:19:00 UTC')

  end

  subject { @help_desk }

  it { should respond_to(:name) }
  it { should respond_to(:urgency) }
  it { should respond_to(:user_id) }
  it { should respond_to(:location_id) }
  it { should respond_to(:description) }
  it { should respond_to(:issue_status) }
  it { should respond_to(:issue_resolution_description) }
  it { should respond_to(:closed_user_id) }
  it { should respond_to(:closed_date_time) }
  it { should respond_to(:help_desk_attachment) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @help_desk.name = nil }
    it { should_not be_valid }
  end

  describe 'when urgency is not present' do
    before { @help_desk.urgency = nil }
    it { should_not be_valid }
  end

  describe 'when user_id is not present' do
    before { @help_desk.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when location_id is not present' do
    before { @help_desk.location_id = nil }
    it { should_not be_valid }
  end
end
