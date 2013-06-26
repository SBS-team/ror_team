require 'minitest_helper'

describe Job do

  subject{Job.new}

  context 'relationships between tables' do
    it {must have_many(:resumes)}
    it {must have_many(:users).through(:resumes)}
  end

  context 'test "jobs" db column' do
    it { must have_db_column(:title).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'validates job model' do
    it { must validate_presence_of(:title) }
    it { must ensure_length_of(:title).is_at_least(3).is_at_most(45) }
    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(5).is_at_most(1000) }
  end

end
