require 'minitest_helper'

describe ProjectService do

  subject { ProjectService.new }

  context 'ProjectService db columns' do
    it { must have_db_column(:project_id).of_type(:integer) }
    it { must have_db_column(:service_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'ProjectService relationship' do
    it { must belong_to(:project) }
    it { must belong_to(:service) }
  end

  context 'ProjectService validations attributes' do
    it { must validate_presence_of(:project_id) }
    it { must validate_numericality_of(:project_id).only_integer }
    it { must ensure_length_of(:project_id).is_at_least(0) }

    it { must validate_presence_of(:service_id) }
    it { must validate_numericality_of(:service_id).only_integer }
    it { must ensure_length_of(:service_id).is_at_least(0) }
  end

end
