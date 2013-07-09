require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ViewTest do

  describe "#index" do

    it 'page must have next content' do
      visit company_index_path
      current_path.must_equal company_index_path
      assert page.has_content?(I18n.t 'company.index.our_skills')
      assert page.has_content?(I18n.t 'company.index.command_development')
      assert page.has_content?(I18n.t 'company.index.development_system')
      assert page.has_content?(I18n.t 'company.index.feedback_odesk')
      assert page.has_content?(I18n.t 'company.index.service_prode')

      assert page.has_content?(I18n.t 'shared.post_jobs.latest_posts')
      assert page.has_content?(I18n.t 'shared.post_jobs.vacancies')
      assert page.has_content?(I18n.t 'shared.post_jobs.by')

      assert page.has_content?(I18n.t 'layouts.application.ror_team')
      assert page.has_content?(I18n.t 'layouts.application.blog')
      assert page.has_content?(I18n.t 'layouts.application.careers')
      assert page.has_content?(I18n.t 'layouts.application.company')
      assert page.has_content?(I18n.t 'layouts.application.contact')
      assert page.has_content?(I18n.t 'layouts.application.team')
      assert page.has_content?(I18n.t 'layouts.application.work')
      assert page.has_content?(I18n.t 'layouts.application.follow_facebook')
      assert page.has_content?(I18n.t 'layouts.application.follow_twitter')
      assert page.has_content?(I18n.t 'layouts.application.mail_scype')
    end

    it "if click on job then redirect to jobs(carrier)" do
      job = FactoryGirl.create(:job)
      visit company_index_path
      assert page.has_content?(job.title)
      click_link job.title
      sleep(3)
      current_path.must_equal job_path(job)
      sleep(3)
    end

    it "if click button Resume then redirect to jobs(carrier)" do
      job = FactoryGirl.create(:job)
      visit company_index_path
      assert page.has_content?(I18n.t 'shared.post_jobs.send_resume')
      click_on I18n.t 'shared.post_jobs.send_resume'
      sleep(3)
      current_path.must_equal job_path(job)
      sleep(3)
    end

    it "if click on post then redirect to posts(blog)" do
      post = FactoryGirl.create(:post, admin_id: FactoryGirl.create(:admin_user).id, :upload_files => [FactoryGirl.create(:upload_file)])
      visit company_index_path
      assert page.has_content?(post.title)
      click_link post.title
      sleep(3)
      current_path.must_equal post_path(post)
      sleep(3)
    end

    it "if service exists then must show" do
      service = FactoryGirl.create(:service, :upload_files => [FactoryGirl.create(:upload_file)])
      visit company_index_path
      assert page.has_content?(service.name)
    end

    it "if technology_categories exist, they must be visible" do
      tc1 = FactoryGirl.create(:technology_category)
      tc2 = FactoryGirl.create(:technology_category)
      visit company_index_path
      assert page.has_content?(tc1.name)
      assert page.has_content?(tc2.name)
    end

  end
end

