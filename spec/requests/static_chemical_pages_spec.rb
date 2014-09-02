require 'spec_helper'

describe 'Chemical Statistics' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:position) { FactoryGirl.create(:position, account_id: account.id) }

  let!(:admin) do
    FactoryGirl.create(:admin,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  subject { page }
end
