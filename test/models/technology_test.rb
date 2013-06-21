require 'test_helper'

describe Technology do

  subject { Technology.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:technology_category_id).of_type(:integer) }
    it { must have_db_column(:project_technology_category_id).of_type(:integer) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do

    it { must have_many(:project_technology_categories) }
    it { must have_many(:projects).through(:project_technology_categories) }

    it { must belong_to(:technology_category) }
  end


end
