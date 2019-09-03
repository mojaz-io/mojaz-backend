require_relative "boot"

# only require Rails parts that we actually use, this shaves off some memory
# ActiveStorage, ActionCable and TestUnit are not currently used by the app
# see <https://github.com/rails/rails/blob/v5.2.3/railties/lib/rails/all.rb>
%w[
  active_model/railtie
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  sprockets/railtie
  action_mailbox/engine
  action_text/engine
].each do |railtie|
  require railtie
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mojaz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoload_paths += Dir["#{config.root}/app/labor/"]

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
