require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ViewTest do

  it 'home' do
    visit root_path
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.company')
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.work')
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.team')
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.careers')
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.contact')
    page.has_content?(I18n.t 'layouts.application.ror_team')
    click_link I18n.t('layouts.application.blog')
    page.has_content?(I18n.t 'layouts.application.ror_team')
  end

end