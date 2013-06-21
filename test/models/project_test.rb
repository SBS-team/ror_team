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


end
