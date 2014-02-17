require 'yaml'

module FeatureToggleHelper
  FEATURE_TOGGLE_PATH = "#{ENV['HOME']}/feature_toggles.yml"

  def self.method_missing(name)
    if name.to_s.ends_with?('?') && !methods.include?(name)
      load_feature_toggles[name[0...-1]]
    else
      super
    end
  end

  def self.load_feature_toggles
    YAML.load_file(FEATURE_TOGGLE_PATH)
  end
end
