module TimeOffRequestsHelper

  def BooleanToWordsTimeOff
    value ? 'Approved' : 'Denied'
  end
end

