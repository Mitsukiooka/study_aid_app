module Enumerizable
  extend ActiveSupport::Concern

  included do
    extend Enumerize

    File.read("#{Rails.root}/config/locales/enumerize.ja.yml").tap do |f|
      YAML.load(f)["ja"]["enumerize"][self.model_name.i18n_key.to_s].each do |k, h|
        enumerize k.to_sym, in: h.keys
      end
    end

    # I18n.t("enumerize.#{self.model_name.i18n_key.to_s}").each do |k, h|
    #   enumerize k.to_sym, in: h.keys
    # end

  end

  module ClassMethods
    def boolean_options
      [["はい", true],["いいえ", false]]
    end
  end

end