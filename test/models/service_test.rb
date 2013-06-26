require 'minitest_helper'

describe Service do

  subject { Service.new }

  context 'Service db columns' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'Service relationship' do
    it { must have_many(:project_services).dependent(:destroy)}
    it { must have_many(:projects).through(:project_services) }
  end

  context 'Service validations attributes' do
    it { must validate_presence_of(:name)}
    it { must validate_uniqueness_of(:name) }
    it { must ensure_length_of(:name).is_at_least(5).is_at_most(45) }
  end

end