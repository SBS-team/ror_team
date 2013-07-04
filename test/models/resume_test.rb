require 'minitest_helper'

describe Resume do

  context 'Test' do
    before :each do
      #FactoryGirl.create(:resume)
      #@resume = FactoryGirl.create(:resume, :upload_files =>[UploadFile.create(:filename => File.open(Rails.root.join('1.jpg')))])

    end
    puts @resume
  end

  #subject { Resume.new }
  #
  #context 'Resume db columns' do
  #  it { must have_db_column(:description).of_type(:text) }
  #  it { must have_db_column(:job_id).of_type(:integer) }
  #  it { must have_db_column(:created_at).of_type(:datetime) }
  #  it { must have_db_column(:updated_at).of_type(:datetime) }
  #  it { must have_db_column(:name).of_type(:string) }
  #  it { must have_db_column(:phone).of_type(:string) }
  #  it { must have_db_column(:email).of_type(:string) }
  #end
  #
  #context 'Resume relationship' do
  #  it {must belong_to(:job)}
  #  it {must have_many(:upload_files).dependent(:destroy)}
  #end
  #
  #context 'Resume validations attributes' do
  #  it { must ensure_length_of(:description).is_at_most(3000) }
  #
  #  it { must validate_presence_of(:job_id) }
  #  it { must validate_numericality_of(:job_id).only_integer }
  #  it { must ensure_length_of(:job_id).is_at_least(0) }
  #
  #  it { must validate_presence_of(:name) }
  #  it { must ensure_length_of(:name).is_at_least(2).is_at_most(40) }
  #
  #  it { must validate_presence_of(:email) }
  #  it { must allow_value("a@b.com").for(:email) }
  #
  #  it { must validate_presence_of(:phone) }
  #  it { must ensure_length_of(:phone).is_at_most(50) }
  #
  #  #it { must allow_value('1.doc').for(:upload_files) }
  #end


end
