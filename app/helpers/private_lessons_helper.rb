module PrivateLessonsHelper
  def lessons_full_name(person)
    "#{person.first_name} #{person.last_name}"
  end
end
