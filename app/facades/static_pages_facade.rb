class StaticPagesFacade
  attr_reader :locations

  def initialize(user)
    @private_lessons = PrivateLesson.same_account_as(user)
    @locations = Location.same_account_as(user)
    @users = User.same_account_as(user)
    @chemical_records = ChemicalRecord.same_account_as(user)
  end

  # Private Lessons
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

  # Employees
  def total_male_employees(location)
    @users.for_location(location).male.count
  end

  def total_female_employees(location)
    @users.for_location(location).female.count
  end

  def total_employees(location)
    @users.for_location(location).count
  end

  def admin(location)
    @users.admin.for_location(location).count
  end

  def active(location)
    @users.active.for_location(location).count
  end

  def inactive(location)
    @users.inactive.for_location(location).count
  end

  def shirt_sizes(location)
    @users.group(:shirt_size).count
  end

  def male_suit_sizes(location)
    @users.male.group(:suit_size).count
  end

  def female_one_piece_suit_sizes(location)
    @users.female.group(:femalesuit).count
  end

  def female_top_sizes(location)
    @users.female.group(:shirt_size).count
  end

  def female_bottom_sizes(location)
    @users.female.group(:suit_size).count
  end

  # Chemical Records
  def minimum(metric, id)
    @chemical_records.where(pool_id: id).minimum(metric)
  end

  def maximum(metric, id)
    @chemical_records.where(pool_id: id).maximum(metric)
  end

  def average(metric, id)
    @chemical_records.where(pool_id: id).average(metric)
  end

  def total_records(metric, id)
    @chemical_records.where(pool_id: id).count(metric)
  end

end
