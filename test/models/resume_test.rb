require 'minitest_helper'

describe Resume do

  subject { Resume.new }

  context 'Resume db columns' do
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
    it { must have_db_column(:user_id).of_type(:integer) }
    it { must have_db_column(:job_id).of_type(:integer) }
  end

  context 'Resume relationship' do
    it {must belong_to(:user)}
    it {must belong_to(:job)}
  end

  context 'Resume validations attributes' do
    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(5).is_at_most(1000) }

    it { must validate_presence_of(:user_id) }
    it { must validate_numericality_of(:user_id).only_integer }
    it { must ensure_length_of(:user_id).is_at_least(0) }

    it { must validate_presence_of(:job_id) }
    it { must validate_numericality_of(:job_id).only_integer }
    it { must ensure_length_of(:job_id).is_at_least(0) }
  end

end
