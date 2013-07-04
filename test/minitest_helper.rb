ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/rails/shoulda'
require 'capybara/rails'

MiniTest::Reporters.use!

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  # include Capybara::RSpecMatchers
  include Capybara::DSL
  Capybara.current_driver = Capybara.javascript_driver
end

def in_browser(name)
  Capybara.session_name = name
  yield
end

class ActionController::TestCase
  include Devise::TestHelpers
end