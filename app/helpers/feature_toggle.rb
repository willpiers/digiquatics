require 'yaml'

module FeatureToggle
  FEATURE_TOGGLE_PATH = "#{ENV['HOME']}/feature_toggles.yml"

  def self.method_missing(name, *arguments)
    if name.to_s.ends_with?('?') && !methods.include?(name)
      show_feature? feature_toggles[name[0...-1]], arguments[0]
    else
      super
    end
  end

  def self.feature_toggles
    feature_toggles = load_feature_toggles

    feature_toggles.is_a?(Hash) ? feature_toggles : {}
  end

  def self.load_feature_toggles
    if File.exist?(FEATURE_TOGGLE_PATH)
      YAML.load_file(FEATURE_TOGGLE_PATH)
    else
      Rails.logger.warn("WARN: missing file: #{FEATURE_TOGGLE_PATH}")
    end
  end

  def self.show_feature? toggle, user
    if user.nil?
      toggle == true
    elsif boolean_or_nil? toggle
      !!toggle
    else
      toggle.to_s.split(',').include? user.account_id.to_s
    end
  end

  def self.boolean_or_nil? value
    !!value == value || value.nil?
  end
end
