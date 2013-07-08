require 'minitest_helper'

describe Job do

  subject{Job.new}

  context 'relationships between tables' do
    it {must have_many(:resumes)}
  end

  context 'test "jobs" db column' do
    it { must have_db_column(:title).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'validates job model' do
    it { must validate_presence_of(:title) }
    it { must validate_presence_of(:description) }
  end

end
