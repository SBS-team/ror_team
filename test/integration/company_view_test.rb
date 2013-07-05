require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class CompanyTest < IntegrationTest

  describe "#index" do

    it 'page must has next content' do
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
      assert page.has_content?(I18n.t 'shared.post_jobs.send_resume')
      click_link job.title
      sleep(3)
      current_path.must_equal job_path(job)
      sleep(3)
    end

=begin
    it "if click on post then redirect to posts(blog)" do
      post = FactoryGirl.create(:post, :upload_files =>[UploadFile.create(:filename => File.open(Rails.root.join('1.jpg')))])
      visit company_index_path
      assert page.has_content?(post.title)
      click_link post.title
      sleep(3)
      current_path.must_equal post_path(post)
      sleep(3)
    end
=end

    it "if click on service then redirect to posts(blog)" do
      service = FactoryGirl.create(:service, :upload_files =>[UploadFile.create(:filename => File.open(Rails.root.join('1.jpg')))])
      visit company_index_path
      assert page.has_content?(service.name)
    end
  end
end

