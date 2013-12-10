require 'minitest_helper'

describe JobsTechnology do

  subject{JobsTechnology.new}

  context 'relationships between tables' do
    it { must belong_to(:job) }
    it { must belong_to(:technology) }
  end

  context 'test "jobs" db column' do
    it { must have_db_column(:job_id).of_type(:integer) }
    it { must have_db_column(:technology_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'validates job model' do
    it { must validate_presence_of(:job_id) }
    it { must validate_numericality_of(:job_id).only_integer }
    it { must ensure_length_of(:job_id).is_at_least(0) }
    it { must validate_presence_of(:technology_id) }
    it { must validate_numericality_of(:technology_id).only_integer }
    it { must ensure_length_of(:technology_id).is_at_least(0) }
  end

end