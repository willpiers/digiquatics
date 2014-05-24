class StaticPagesFacade
  attr_reader :locations

  def initialize(user)
    @private_lessons = PrivateLesson.same_account_as(user)
    @locations = Location.same_account_as(user)
  end

  def unclaimed_for(location)
    @private_lessons.for_location(location).unclaimed.count
  end

  def claimed_for(location)
    @private_lessons.for_location(location).claimed.count
  end

  def total_for(location)
    @private_lessons.for_location(location).count
  end

  def unclaimed_total
    @unclaimed_total ||= @private_lessons.unclaimed.count
  end

  def claimed_total
    @claimed_total ||= @private_lessons.claimed.count
  end

  def total
    @total ||= @private_lessons.count
  end
end
