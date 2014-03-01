module PrivateLessonsHelper
  def student_full_name(student)
    "#{student.first_name} #{student.last_name}"
  end

  def instructor_full_name(instructor)
    "#{instructor.first_name} #{instructor.last_name}"
  end
end
