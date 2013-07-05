ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/rails/shoulda'
require 'capybara/rails'

MiniTest::Reporters.use!

class ViewTest < MiniTest::Spec
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  Capybara.current_driver = Capybara.javascript_driver

  MiniTest::Spec.register_spec_type /ViewTest/, self
end

def in_browser(name)
  Capybara.session_name = name
  yield
end

class ActionController::TestCase
  include Devise::TestHelpers
end