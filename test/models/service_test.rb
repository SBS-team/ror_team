require 'test_helper'

describe Service do

  subject { Service.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:name).of_type(:string) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must have_many(:project_services) }
    it { must have_many(:projects).through(:project_services) }
  end

  describe "custom tests" do
    before do
      @service = FactoryGirl.build(:service)
    end

    it "must be valid with valid attr" do
      @service.save
      @service.wont_be_nil
      @service.must_be_kind_of Service
    end

    describe "must be invalid" do
      it "without name" do
        @service.name = nil
        @service.valid?.must_equal false
      end

      it "if name already exists" do
        serv1 = FactoryGirl.create(:service, :name => "super service")
        @service.name = "super service"
        @service.valid?.must_equal false
      end

      it "if name length < 5" do
        @service.name = "X"
        @service.valid?.must_equal false
      end

      it "if name length > 45" do
        @service.name = "aaaaa_bbbbb_ccccc_ddddd_aaaaa_bbbbb_cccccc_ddddd"
        @service.valid?.must_equal false
      end
    end
  end
end