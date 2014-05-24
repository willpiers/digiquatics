class StaticPagesFacade
  attr_reader :locations

  def initialize(user)
    @private_lessons = PrivateLesson.same_account_as(user)
    @locations = Location.same_account_as(user)
  end

  def unclaimed_for(location)
    @private_lessons.where(location_id: location.id, user_id: nil).count
  end

  def claimed_for(location)
    @private_lessons.where(location_id: location.id).where.not(user_id: nil)
    .count
  end

  def total_for(location)
    @private_lessons.where(location_id: location.id).count
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
