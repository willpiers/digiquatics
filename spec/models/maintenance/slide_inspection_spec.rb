require 'spec_helper'

describe SlideInspection do
  before do
    @slide_inspection = SlideInspection.new(slide_id: 1,
                                            user_id: 'Bolts tight?',
                                            notes: 'all is good',
                                            all_ok: true)
  end

  subject { @slide_inspection }

  it { should respond_to(:slide_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:notes) }
  it { should respond_to(:all_ok) }
end
