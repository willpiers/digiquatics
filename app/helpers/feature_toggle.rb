require 'yaml'

module FeatureToggle
  FEATURE_TOGGLE_PATH = "#{ENV['HOME']}/feature_toggles.yml"

  def self.method_missing name, *arguments
    if name.to_s.ends_with? '?'
      show_feature? toggle: feature_toggles[name.to_s.chop], user: arguments[0]
    else
      super
    end
  end

  def self.show_feature? toggle:, user:
    if user.nil? || toggle == !!toggle || toggle.nil?
      toggle == true
    else
      toggle.to_s.split(',').include? user.account_id.to_s
    end
  end

  def self.feature_toggles
    if File.exist?(FEATURE_TOGGLE_PATH)
      @feature_toggles ||= YAML.load_file FEATURE_TOGGLE_PATH
    else
      Rails.logger.warn "WARN: missing file: #{FEATURE_TOGGLE_PATH}"
      {}
    end
  end
end
