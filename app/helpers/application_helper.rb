module ApplicationHelper

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
    value ? "Y" : "N"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning",
      notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    content_tag :div, class: "row" do
      content_tag :div, class: "col-md-8 col-md-offset-2" do
        flash.map do |msg_type, message|
          content_tag :div, message,
            class: "alert #{bootstrap_class_for(msg_type)}"
        end.join.html_safe
      end
    end
  end
end
