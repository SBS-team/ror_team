require 'minitest_helper'

describe TeamRole do

  subject { TeamRole.new }

  context 'TeamRole model connection' do
    it { must have_many(:team_members) }
  end

  context 'TeamRole db column' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'TeamRole validation' do
    it { must validate_presence_of(:name) }
    it { must ensure_length_of(:name).is_at_least(1).is_at_most(50) }
  end

end