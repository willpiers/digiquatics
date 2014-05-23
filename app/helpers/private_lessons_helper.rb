module PrivateLessonsHelper
  PRIVATE_LESSON_PARAMS = [
    :email, :phone_number, :parent_first_name,
    :parent_last_name, :contact_method, :instructor_gender,
    :notes, :day, :time, :preferred_location, :user_id, :attachment,
    :number_lessons, :lesson_objective, :account_id, :location_id,
    :claimed_on, :completed_on,
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
