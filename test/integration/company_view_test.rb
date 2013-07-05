require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class CompanyTest < IntegrationTest

  describe "#index" do
    it 'page must has next content' do
      visit company_index_path
      assert page.has_content?(I18n.t 'company.index.our_skills')
      assert page.has_content?(I18n.t 'company.index.command_development')
      assert page.has_content?(I18n.t 'company.index.development_system')
      assert page.has_content?(I18n.t 'company.index.feedback_odesk')
      assert page.has_content?(I18n.t 'company.index.service_prode')

      assert page.has_content?(I18n.t 'shared.post_jobs.latest_posts')
      assert page.has_content?(I18n.t 'shared.post_jobs.vacancies')
      assert page.has_content?(I18n.t 'shared.post_jobs.by')
      assert page.has_content?(I18n.t 'shared.post_jobs.send_resume')


    end
  end

=begin
  it 'Email Cannot be blank' do
    visit '/'
    click_link 'Contact'
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    click_button 'Send Message'
    page.must have_content('Email cannot be blank.')
  end
=end

end