ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/rails/shoulda'
require 'capybara/rails'

MiniTest::Reporters.use!

=begin
class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
end
=end