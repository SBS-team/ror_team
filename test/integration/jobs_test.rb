require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ViewTest do
  before :each do
    5.times {FactoryGirl.create(:job)}
  end
  it 'index test' do
    visit '/jobs'
    assert page.has_content?("Open Vacancies")
    assert page.has_content?("Send resume")
    assert page.has_content?("Job title 1")
    assert page.has_content?("Job title 2")
    assert page.has_content?("Job title 3")
    click_button('Send resume')
    assert page.has_content?("Name can't be blank")
    assert page.has_content?('Name is too short (minimum is 2 characters)')
    assert page.has_content?("Email can't be blank")
    assert page.has_content?('Email is invalid')
    assert page.has_content?("Phone can't be blank")
    assert page.has_content?("Description can't be blank and file is not attached")
    fill_in 'resume[name]', :with => 'Jack Vorobey'
    fill_in 'resume[email]', :with => 'jack0611@mail.ru'
    fill_in 'resume[phone]', :with => '+380999673061'
    fill_in 'resume[description]', :with => 'A resume is a document which includes education, experience, skills, and accomplishments that is used to apply for jobs. Before you start work on your resume, review free samples that fit a variety of employment situations. These examples and templates provide job seekers with resume formats that will work for every job seeker.'
    find('#linkfile').click
    find('#fileinput').set(Rails.root.join('test/factories/files/image.jpg'))
    click_button('Send resume')
    assert page.has_content?('Upload files not doc, pdf types')
    find('#linkfile').click
    find('#fileinput').set(Rails.root.join('test/factories/files/1.doc'))
    click_button('Send resume')

    assert page.has_content?('Your resume is successfully sent.')
  end
end