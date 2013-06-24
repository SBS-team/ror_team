require 'test_helper'

describe ProjectService do

  subject { ProjectService.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:project_id).of_type(:integer) }
    it { must have_db_column(:service_id).of_type(:integer) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must belong_to(:project) }
    it { must belong_to(:service) }
  end

  it { subject.must_be_kind_of ProjectService }

  describe "creation" do
    it "must be" do
      project = FactoryGirl.create(:project)
      service = FactoryGirl.create(:service)
      project.services << service
      service.save
      project.save
      pro_serv = ProjectService.where(:project_id => project.id).first
      pro_serv.wont_be_nil
      pro_serv.service_id.must_equal service.id
    end
  end


end
