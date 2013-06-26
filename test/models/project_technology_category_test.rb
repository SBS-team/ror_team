require 'minitest_helper'

describe ProjectTechnologyCategory do

  subject { ProjectTechnologyCategory.new }

  context 'ProjectTechnologyCategory db columns' do
    it { must have_db_column(:project_id).of_type(:integer) }
    it { must have_db_column(:technology_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'ProjectTechnologyCategory relationship' do
    it { must belong_to(:project) }
    it { must belong_to(:technology) }
  end

  context 'ProjectTechnologyCategory validations attributes' do
    it { must validate_presence_of(:project_id) }
    it { must validate_numericality_of(:project_id).only_integer }
    it { must ensure_length_of(:project_id).is_at_least(0) }

    it { must validate_presence_of(:technology_id) }
    it { must validate_numericality_of(:technology_id).only_integer }
    it { must ensure_length_of(:technology_id).is_at_least(0) }
  end

end
