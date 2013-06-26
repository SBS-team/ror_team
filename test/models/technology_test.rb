require 'minitest_helper'

describe Technology do

  subject { Technology.new }

  context 'Technology db columns' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:technology_category_id).of_type(:integer) }
    it { must have_db_column(:project_technology_category_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'Technology relationship' do
    it { must have_many(:project_technology_categories).dependent(:destroy) }
    it { must have_many(:projects).through(:project_technology_categories) }
    it { must belong_to(:technology_category) }
  end

  context 'Technology validations attributes' do
    it { must validate_presence_of(:name)}
    it { must validate_uniqueness_of(:name)}
    it { must ensure_length_of(:name).is_at_least(1).is_at_most(45) }

    it { must validate_presence_of(:technology_category_id) }
    it { must validate_numericality_of(:technology_category_id).only_integer }
    it { must ensure_length_of(:technology_category_id).is_at_least(0) }
  end

end
