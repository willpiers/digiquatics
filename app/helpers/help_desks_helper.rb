module HelpDesksHelper
  def approve_link_text(approvable)
    approvable.approved? ? 'Un-approve' : 'Approve'
  end

  def boolean_to_words(value)
    value ? 'Open' : 'Closed'
  end
end
