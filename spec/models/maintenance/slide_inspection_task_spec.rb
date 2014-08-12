require 'spec_helper'

describe SlideInspectionTask do
  before do
    @slide_inspection_task = SlideInspectionTask.new(slide_inspection_id: 1,
                                                     task_name: 'Bolts tight?',
                                                     completed: false)
  end

  subject { @slide_inspection_task }

  it { should respond_to(:slide_inspection_id) }
  it { should respond_to(:task_name) }
  it { should respond_to(:completed) }
end
