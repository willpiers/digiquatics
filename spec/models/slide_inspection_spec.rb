require 'spec_helper'

describe SlideInspection do
  before do
    @slide_inspection = SlideInspection.new(slide_id: 1,
                                            user_id: 'Bolts tight?',
                                            notes: 'all is good')
  end

  subject { @slide_inspection }

  it { should respond_to(:slide_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:notes) }
end
