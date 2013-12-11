require 'minitest_helper'

describe TeamMember do

  subject { TeamMember.new }

  context 'TeamMember model connection' do
    it { must have_one(:upload_file) }
    it { must belong_to(:team_role) }
  end

  context 'TeamMember db column' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:last_name).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'TeamMember validation' do
    it { must validate_presence_of(:name) }
    it { must ensure_length_of(:name).is_at_least(2).is_at_most(50) }
    it { must validate_presence_of(:last_name) }
    it { must ensure_length_of(:last_name).is_at_least(2).is_at_most(50) }
    it { must validate_presence_of(:team_role_id) }
    it { must validate_numericality_of(:team_role_id).only_integer }
    it { must ensure_length_of(:team_role_id).is_at_least(0) }
  end

end