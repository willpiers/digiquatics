module UsersHelper
  def age(dob)
    return '?' unless dob

    now = Time.now.utc.to_date

    extra_year = now.month > dob.month ||
      (now.month == dob.month && now.day >= dob.day)

    now.year - dob.year - (extra_year ? 0 : 1)
  end
end
