module ApplicationHelper

  def full_title(page_title) base_title = 'DigiQuatics'
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
    fields = f.fields_for(association, new_object, child_index: id) do |b|
      render(association.to_s.singularize + '_fields', f: b)
    end
    link_to(name, '#', class: 'add_fields',
      data: {id: id, fields: fields.gsub("\n", '')})
  end

  def admin_user
    redirect_to(signin_path) unless current_user.admin?
  end

  def us_states
    [
      %w(AK AK),
      %w(AL AL),
      %w(AR AR),
      %w(AZ AZ),
      %w(CA CA),
      %w(CO CO),
      %w(CT CT),
      %w(DC DC),
      %w(DE DE),
      %w(FL FL),
      %w(GA GA),
      %w(HI HI),
      %w(IA IA),
      %w(ID ID),
      %w(IL IL),
      %w(IN IN),
      %w(KS KS),
      %w(KY KY),
      %w(LA LA),
      %w(MA MA),
      %w(MD MD),
      %w(ME ME),
      %w(MI MI),
      %w(MN MN),
      %w(MO MO),
      %w(MS MS),
      %w(MT MT),
      %w(NC NC),
      %w(ND ND),
      %w(NE NE),
      %w(NH NH),
      %w(NJ NJ),
      %w(NM NM),
      %w(NV NV),
      %w(NY NY),
      %w(OH OH),
      %w(OK OK),
      %w(OR OR),
      %w(PA PA),
      %w(RI RI),
      %w(SC SC),
      %w(SD SD),
      %w(TN TN),
      %w(TX TX),
      %w(UT UT),
      %w(VA VA),
      %w(VT VT),
      %w(WA WA),
      %w(WI WI),
      %w(WV WV),
      %w(WY WY)
    ]
  end

end
