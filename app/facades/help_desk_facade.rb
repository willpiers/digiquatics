class HelpDeskFacade
  def initialize(help_desk)
    @help_desk = help_desk
  end

  def closer
    @closed_by ||= User.find(@help_desk.closed_user_id)
  end

  def submitter
    @submitter ||= @help_desk.user
  end
end
