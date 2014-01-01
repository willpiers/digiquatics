module ApplicationHelper
include Math

# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Aquatics App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def boolean_to_words(value)
    value ? "Yes" : "No"
  end

  def age(dob)
    return '?' if !dob
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  #SI Index equation
  def si_index(ph_reading, pool_temp, calcium_hardness, total_alkalinity)
    return '?' if (!ph_reading or !pool_temp or !calcium_hardness or !total_alkalinity) 
    ph = ph_reading
    temp = ((0.7571*log(pool_temp))-2.6639)
    ch = ((0.4341*log(calcium_hardness))-0.3926)
    ta = ((0.4341*log(total_alkalinity))+0.0074)
    tds = 12.1
    @si = (ph + temp + ch + ta - tds)
    return @si
  end

  #SI General Recommendaiton
  def si_index_description(si_index)
    return '?' if !si_index
    @answer = si_index
    case @answer
      when 0 .. 2
        puts ""
      else
        puts "normal"
    end
    return @answer 
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    content_tag :div, class: "row" do
      content_tag :div, class: "col-md-8 col-md-offset-2" do
        flash.map do |msg_type, message|
          content_tag :div, message, class: "alert #{bootstrap_class_for(msg_type)}"
        end.join.html_safe
      end
    end
  end
end