# == Schema Information
#
# Table name: jobs_technologies
#
#  id            :integer          not null, primary key
#  job_id        :integer
#  technology_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jobs_technology, :class => 'JobsTechnologies' do
  end
end
