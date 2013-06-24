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

  describe "custom tests" do
    before do
      @tech_cat = FactoryGirl.build(:technology_category)
    end

    it "must be valid with valid attr" do
      @tech_cat.save
      @tech_cat.wont_be_nil
      @tech_cat.must_be_kind_of TechnologyCategory
    end

    describe "must be invalid" do
      it "without name" do
        @tech_cat.name = nil
        @tech_cat.valid?.must_equal false
      end

      it "if name already exists" do
        tech_cat1 = FactoryGirl.create(:technology_category, :name => "bla-bla-bla")
        @tech_cat.name = "bla-bla-bla"
        @tech_cat.valid?.must_equal false
      end

      it "if name length < 3" do
        @tech_cat.name = "X"
        @tech_cat.valid?.must_equal false
      end

      it "if name length > 45" do
        @tech_cat.name = "aaaaa_bbbbb_ccccc_ddddd_aaaaa_bbbbb_cccccc_ddddd"
        @tech_cat.valid?.must_equal false
      end
    end
  end
end
