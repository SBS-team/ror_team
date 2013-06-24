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

  describe "custom tests" do
    before do
      @tech = FactoryGirl.build(:technology)
    end

    it "must be valid with valid attr" do
      @tech.save
      @tech.wont_be_nil
      @tech.must_be_kind_of Technology
    end

    describe "must be invalid" do
      it "without name" do
        @tech.name = nil
        @tech.valid?.must_equal false
      end

      it "if name already exists" do
        tech1 = FactoryGirl.create(:technology, :name => "technology_1")
        @tech.name = "technology_1"
        @tech.valid?.must_equal false
      end

      it "if name length < 5" do
        @tech.name = "X"
        @tech.valid?.must_equal false
      end

      it "if name length > 45" do
        @tech.name = "aaaaa_bbbbb_ccccc_ddddd_aaaaa_bbbbb_cccccc_ddddd"
        @tech.valid?.must_equal false
      end

      it "without technology_category_id" do
        @tech.technology_category_id = nil
        @tech.valid?.must_equal false
      end

      it "if technology_category_id is float" do
        @tech.technology_category_id = 3.5
        @tech.valid?.must_equal false
      end

    end
  end
end
