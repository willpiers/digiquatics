class PrivateLessonFacade
  attr_reader :private_lessons

  def initialize(private_lesson)
    @private_lesson = private_lessons
  end

  def unclaimed_by_location
    @unclaimed_by_location ||= @private_lessons.where(location_id: location.id, user_id: nil).count
  end

  def claimed_by_location
    @claimed_by_location ||= @private_lessons.where(location_id: location.id).where.not(user_id: nil).count
  end

  def total_by_location
    @total_by_location ||= @private_lessons.where(location_id: location.id).count
  end

  def unclaimed_total
    @unclaimed_total ||= @private_lessons.where(user_id: nil).count
  end

  def claimed_total
    @claimed_total ||= @private_lessons.where.not(user_id: nil).count
  end

  def total
    @total ||= @private_lessons.count
  end
end
