require 'test_helper'

describe Project do

  subject { Project.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:since).of_type(:date) }
    it { must have_db_column(:team_size).of_type(:integer) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must have_many(:project_services) }
    it { must have_many(:services).through(:project_services) }

    it { must have_many(:project_technology_categories).dependent(:destroy) }
    it { must have_many(:technologies).through(:project_technology_categories) }
  end

  describe "custom tests" do
    before do
      @project = FactoryGirl.build(:project)
    end

    it "must be valid with valid attr" do
      @project.save
      @project.wont_be_nil
      @project.must_be_kind_of Project
    end

    describe "must be invalid" do
      it "without name" do
        @project.name = nil
        @project.valid?.must_equal false
      end

      it "if name already exists" do
        project1 = FactoryGirl.create(:project, :name => "super project")
        @project.name = "super project"
        @project.valid?.must_equal false
      end

      it "if name length < 3" do
        @project.name = "X"
        @project.valid?.must_equal false
      end

      it "if name length > 45" do
        @project.name = "aaaaa_bbbbb_ccccc_ddddd_aaaaa_bbbbb_cccccc_ddddd"
        @project.valid?.must_equal false
      end

      it "without description" do
        @project.description = nil
        @project.valid?.must_equal false
      end

      it "without date since" do
        @project.since = nil
        @project.valid?.must_equal false
      end

      it "without team_size" do
        @project.team_size = nil
        @project.valid?.must_equal false
      end

      it "with negative team_size" do
        @project.team_size = -2
        @project.valid?.must_equal false
      end

      it "if team_size == 0" do
        @project.team_size = 0
        @project.valid?.must_equal false
      end

      it "if team_size is float" do
        @project.team_size = 3.5
        @project.valid?.must_equal false
      end
    end

  end
end
