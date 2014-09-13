require 'yaml'

module FeatureToggle
  FEATURE_TOGGLE_PATH = "#{ENV['HOME']}/feature_toggles.yml"

  def self.method_missing(name, *args)
    if name.to_s.ends_with?('?') && !methods.include?(name)
      toggle = feature_toggles[name[0...-1]]

      if !!toggle == toggle || toggle.nil?
        !!toggle
      else
        toggle.to_s.split(',').include? args[0].account_id.to_s
      end
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

  def self.boolean? value
    !!value == value
  end
end
