require 'minitest_helper'

describe ViewTest do
  before :each do
    5.times {FactoryGirl.create(:job)}
  end
  it 'index test' do
    visit '/jobs'
    assert page.has_content?('Open Vacancies')
    assert page.has_content?('Send resume')
    assert page.has_content?('Job title')
    click_button('Send resume')
    assert page.has_content?("This field is required.")
    fill_in 'resume[name]', :with => 'Jack Vorobey'
    fill_in 'resume[email]', :with => 'jack0611@mail.ru'
    fill_in 'resume[phone]', :with => '380999673061'
    fill_in 'resume[description]', :with => 'A resume is a document which includes education, experience, skills, and accomplishments that is used to apply for jobs. Before you start work on your resume, review free samples that fit a variety of employment situations. These examples and templates provide job seekers with resume formats that will work for every job seeker.'
    find('#resume_upload_file_attributes_filename').set(Rails.root.join('test/factories/files/1.doc'))
    fill_in 'recaptcha_response_field', :with => 'reCAPTCHA'
    click_button('Send resume')
    assert page.has_content?('Your resume is successfully sent.')
  end
end