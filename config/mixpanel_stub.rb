class MixpanelStub
  def self.track *arguments
    puts "Mixpanel.Track (dev): #{arguments}" unless Rails.env.test?
  end
end
