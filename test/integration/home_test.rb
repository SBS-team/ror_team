require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ViewTest do

  it 'home' do
    visit root_path
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Company'
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Work'
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Team'
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Careers'
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Contact'
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link 'Blog'
    page.has_content?(I18n.t 'layouts.application.ror_team')
  end

end