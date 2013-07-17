require 'minitest_helper'

describe ViewTest do

  before do
    project = FactoryGirl.create(:project, :name => 'the real power', :description => 'very very long and useful post', :since => 1.month.ago, :till => Time.now, :team_size => 3, :upload_files => [FactoryGirl.create(:upload_file)])
    3.times do
      FactoryGirl.create(:project, :upload_files => [FactoryGirl.create(:upload_file)])
    end
    visit projects_path
  end

  it 'must render show' do
    assert page.has_content?('the real power')
    assert page.has_content?('Description_1')
    click_link('the real power')
    assert page.has_no_content?('Description_1')

  end

end