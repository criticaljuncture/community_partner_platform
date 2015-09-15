module I18nAccessor
  extend ActiveSupport::Concern

  class_methods do
    def i18n_accessor(accessor_name)
      define_method accessor_name do
        I18n.t("#{self.class.name.underscore}.#{identifier}")
      end
    end
  end
end
