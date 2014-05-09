module SlideInspectionsHelper
  SLIDE_INSPECTION_PARAMS = [
    :slide_id, :user_id, :notes, slide_inspection_tasks_attributes: [
      :_destroy, :id, :task_name, :completed
    ]
  ]
end
