require 'minitest_helper'

describe Project do

  subject { Project.new }

  context 'Project db columns' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:since).of_type(:date) }
    it { must have_db_column(:team_size).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'Project relationship' do
    it { must have_many(:project_services).dependent(:destroy) }
    it { must have_many(:services).through(:project_services) }
    it { must have_many(:project_technology_categories).dependent(:destroy) }
    it { must have_many(:technologies).through(:project_technology_categories) }
  end

  context 'Project validations attributes' do
    it { must validate_presence_of(:name) }
    it { must validate_uniqueness_of(:name)}
    it { must ensure_length_of(:name).is_at_least(3).is_at_most(45) }

    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(10).is_at_most(500) }

    it { must validate_presence_of(:since)}

    it { must validate_presence_of(:team_size) }
    it { must validate_numericality_of(:team_size).only_integer }
    it { must ensure_length_of(:team_size).is_at_least(0) }
  end

end
