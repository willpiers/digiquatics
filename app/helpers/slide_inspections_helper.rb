module SlideInspectionsHelper
  SLIDE_INSPECTION_PARAMS = [
    :slide_id, :user_id, :notes, :all_ok, slide_inspection_tasks_attributes: [
      :_destroy, :id, :task_name, :completed
    ]
  ]

  def count_completed(slide_inspection_params)
    count = 0
    slide_inspection_params[:slide_inspection_tasks_attributes].values.each do |val|
      if val[:completed] == '1'
        count += 1
      end
    end
    count
  end

  def has_email_alerts?(account)
    account.slides_group_email || account.slides_admin_email || account.slides_location_email
  end
end
