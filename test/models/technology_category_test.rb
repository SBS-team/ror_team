require 'minitest_helper'

describe TechnologyCategory do

  subject { TechnologyCategory.new }

  context 'TechnologyCategory db columns' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'TechnologyCategory relationship' do
    it { must have_many(:technologies).dependent(:destroy) }
  end

  context 'TechnologyCategory validations attributes' do
    it { must validate_presence_of(:name)}
    it { must validate_uniqueness_of(:name)}
    it { must ensure_length_of(:name).is_at_least(1).is_at_most(45) }
  end

end
