require 'test_helper'

describe TechnologyCategory do

  subject { TechnologyCategory.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:name).of_type(:string) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must have_many(:technologies).dependent(:destroy) }
  end


end
