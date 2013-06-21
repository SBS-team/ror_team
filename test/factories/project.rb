FactoryGirl.define do
  factory :project do
    sequence :name do |n|
      "Project_#{n}"
    end
    sequence :description do |n|
      "Description_#{n}"
    end
    rand_obj = Random.new
    date 1.month.ago
    team_size rand_obj.rand(2..6)
  end
end
