module ApplicationHelper

  def full_title(page_title) base_title = 'Aquatics App'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def boolean_to_words(value)
    value ? 'Y' : 'N'
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end

  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    content_tag :div, class: 'row' do
      content_tag :div, class: 'col-md-8 col-md-offset-2' do
        flash.map do |msg_type, message|
          content_tag :div, message,
            class: "alert #{bootstrap_class_for(msg_type)}"
        end.join.html_safe
      end
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to(name, '#', class: 'add_fields',
      data: {id: id, fields: fields.gsub("\n", '')})
  end

  def admin_user
    redirect_to(signin_path) unless current_user.admin?
  end

  def us_states
    [
      ['AK', 'AK'],
      ['AK', 'AK'],
      ['AL', 'AL'],
      ['AR', 'AR'],
      ['AZ', 'AZ'],
      ['CA', 'CA'],
      ['CO', 'CO'],
      ['CT', 'CT'],
      ['DC', 'DC'],
      ['DE', 'DE'],
      ['FL', 'FL'],
      ['GA', 'GA'],
      ['HI', 'HI'],
      ['IA', 'IA'],
      ['ID', 'ID'],
      ['IL', 'IL'],
      ['IN', 'IN'],
      ['KS', 'KS'],
      ['KY', 'KY'],
      ['LA', 'LA'],
      ['MA', 'MA'],
      ['MD', 'MD'],
      ['ME', 'ME'],
      ['MI', 'MI'],
      ['MN', 'MN'],
      ['MO', 'MO'],
      ['MS', 'MS'],
      ['MT', 'MT'],
      ['NC', 'NC'],
      ['ND', 'ND'],
      ['NE', 'NE'],
      ['NH', 'NH'],
      ['NJ', 'NJ'],
      ['NM', 'NM'],
      ['NV', 'NV'],
      ['NY', 'NY'],
      ['OH', 'OH'],
      ['OK', 'OK'],
      ['OR', 'OR'],
      ['PA', 'PA'],
      ['RI', 'RI'],
      ['SC', 'SC'],
      ['SD', 'SD'],
      ['TN', 'TN'],
      ['TX', 'TX'],
      ['UT', 'UT'],
      ['VA', 'VA'],
      ['VT', 'VT'],
      ['WA', 'WA'],
      ['WI', 'WI'],
      ['WV', 'WV'],
      ['WY', 'WY']
    ]
  end

end
