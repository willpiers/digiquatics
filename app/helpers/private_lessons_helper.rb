module PrivateLessonsHelper
  PRIVATE_LESSON_PARAMS = [
    :email, :phone_number, :parent_first_name,
    :parent_last_name, :contact_method, :instructor_gender,
    :notes, :day, :time, :preferred_location, :user_id, :attachment,
    :number_lessons, :lesson_objective, :account_id, :location_id,
    :claimed_on, :completed_on, :sunday_morning, :sunday_afternoon,
    :sunday_evening, :monday_morning, :monday_afternoon, :monday_evening,
    :tuesday_morning, :tuesday_afternoon, :tuesday_evening, :wednesday_morning,
    :wednesday_afternoon, :wednesday_evening, :thursday_morning,
    :thursday_afternoon, :thursday_evening, :friday_morning, :friday_afternoon,
    :friday_evening, :saturday_morning, :saturday_afternoon, :saturday_evening,
    participants_attributes: [
      :_destroy, :id, :private_lesson_id, :first_name, :last_name,
      :sex, :age
    ]
  ]

  def private_lesson_params
    params.require(:private_lesson).permit(PRIVATE_LESSON_PARAMS)
  end

  def lessons_full_name(person)
    "#{person.first_name} #{person.last_name}"
  end

end
