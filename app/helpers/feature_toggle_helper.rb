require 'yaml'

module FeatureToggleHelper
  FEATURE_TOGGLE_PATH = "#{ENV['HOME']}/feature_toggles.yml"

  def self.method_missing(name)
    if name.to_s.ends_with?('?') && !methods.include?(name)
      feature_toggles[name[0...-1]]
    else
      super
    end
  end

  def self.feature_toggles
    feature_toggles = load_feature_toggles

    feature_toggles.is_a?(Hash) ? feature_toggles : {}
  end

  def self.load_feature_toggles
    if File.exists?(FEATURE_TOGGLE_PATH)
      YAML.load_file(FEATURE_TOGGLE_PATH)
    else
      Rails.logger.warn("WARN: missing file: #{FEATURE_TOGGLE_PATH}")
    end
  end
end
