require 'test_helper'

describe ProjectTechnologyCategory do

  subject { ProjectTechnologyCategory.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:project_id).of_type(:integer) }
    it { must have_db_column(:technology_id).of_type(:integer) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must belong_to(:project) }
    it { must belong_to(:technology) }
  end

  it { subject.must_be_kind_of ProjectTechnologyCategory }

  describe "creation" do
    it "must be" do
      project = FactoryGirl.create(:project)
      tech = FactoryGirl.create(:technology)
      project.technologies << tech
      tech.save
      project.save
      pro_tech = ProjectTechnologyCategory.where(:project_id => project.id).first
      pro_tech.wont_be_nil
      pro_tech.technology_id.must_equal tech.id
    end
  end
end
