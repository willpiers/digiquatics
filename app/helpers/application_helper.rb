module ApplicationHelper
  BASE_TITLE = 'DigiQuatics'

  US_STATES = [
    %w(AK AK), %w(AL AL), %w(AR AR), %w(AZ AZ), %w(CA CA), %w(CO CO),
    %w(CT CT), %w(DC DC), %w(DE DE), %w(FL FL), %w(GA GA), %w(HI HI),
    %w(IA IA), %w(ID ID), %w(IL IL), %w(IN IN), %w(KS KS), %w(KY KY),
    %w(LA LA), %w(MA MA), %w(MD MD), %w(ME ME), %w(MI MI), %w(MN MN),
    %w(MO MO), %w(MS MS), %w(MT MT), %w(NC NC), %w(ND ND), %w(NE NE),
    %w(NH NH), %w(NJ NJ), %w(NM NM), %w(NV NV), %w(NY NY), %w(OH OH),
    %w(OK OK), %w(OR OR), %w(PA PA), %w(RI RI), %w(SC SC), %w(SD SD),
    %w(TN TN), %w(TX TX), %w(UT UT), %w(VA VA), %w(VT VT), %w(WA WA),
    %w(WI WI), %w(WV WV), %w(WY WY)
  ]

  def full_title(page_title)
    if page_title.empty?
      BASE_TITLE
    else
      "#{BASE_TITLE} | #{page_title}"
    end
  end

  def boolean_to_words(value)
    value ? 'Yes' : 'No'
  end

  def boolean_to_words_lessons(value)
    value ? 'Y' : 'N'
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id

    fields = f.fields_for(association, new_object, child_index: id) do |b|
      render(association.to_s.singularize + '_fields', f: b)
    end

    link_to name, '#',
            class: 'add_fields',
            data: {
              id: id,
              fields: fields.gsub("\n", '')
            }
  end

  def admin_user
    unless current_user.admin?
      flash[:notice] = 'You must have admin rights to access this page.'
      redirect_to current_user
    end
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def us_states
    US_STATES
  end

  def browser_check
    unless browser.modern?
      flash[:error] = 'You are not using a browser that we support. ' \
        'Please use IE9+, Chrome, Firefox, Safari, or another modern browser.'
    end
  end

  def phone_number_link(text)
    link_to text, "tel:#{text}"
  end

  def new_record_star(date)
    if date <= (Data.today - 7.days) then
      true
    else
      false
    end
  end

  def BooleanToWordsTimeOff(value)
    value ? 'Approved' : 'Denied'
  end

  def BooleanToWordsTimeOffCSS(value)
    value ? 'success' : 'danger'
  end

  def active_nav(controller)
    if params[:controller] == controller then 'active'
    end
  end

  def action_nav(action_name)
    if params[:action] == action_name then 'active'
    end
  end

  def date_and_time(date)
    date ? date.strftime('%-m/%-d/%Y @ %I:%M%p') : ''
  end

  # Need to fix
  def number_my_private_lessons
    PrivateLesson.joins(:account)
                  .same_account_as(current_user).claimed_by(current_user).count
  end

  def number_private_lessons
    PrivateLesson.joins(:account)
                  .same_account_as(current_user).unclaimed.count
  end

  def number_open_issues
    HelpDesk.joins(:location)
            .where(locations: { account_id: current_user.account_id })
            .where(issue_status: true).count
  end

  def number_my_sub_requests
    SubRequest.where(user_id: current_user.id).count

  end

  def number_sub_requests
    SubRequest.joins(:user)
              .where(users: { account_id: current_user.account_id })
              .where(active: true)
              .where(processed: false).count
  end

  def number_admin_sub_requests
    SubRequest.joins(:user)
              .where(users: { account_id: current_user.account_id })
              .where(active: false)
              .where(processed: false).count
  end

  def number_time_off_requests
    TimeOffRequest.joins(:user)
                  .where(users: { account_id: current_user.account_id })
                  .where(active: true).count
  end

  def show_badge_notification(page)
    case page
    when 'private_lessons_queue'
      number_private_lessons > 0
    when 'open_issues'
      number_open_issues > 0
    when 'sub_requests'
      number_sub_requests > 0
    when 'admin_sub_requests'
      number_admin_sub_requests > 0
    when 'time_off_requests'
      number_time_off_requests > 0
    end
  end

  def badge_notifications(page)
    case page
    when 'private_lessons_queue'
      number_private_lessons
    when 'open_issues'
      number_open_issues
    when 'sub_requests'
      number_sub_requests
    when 'admin_sub_requests'
      number_admin_sub_requests
    when 'time_off_requests'
      number_time_off_requests
    end
  end
end
