I18n.enforce_available_locales = true

module ResistanceFishtagRu
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = %i(ru en)
    config.i18n.default_locale = :ru
  end
end
