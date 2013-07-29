require "minitest_helper"

describe LiveChat do

  subject { LiveChat.new }

  context 'LiveChat model relations' do
    it { must belong_to(:admin_user) }
    it { must have_many(:chat_messages) }
  end

  context 'LiveChat db columns' do
    it { must have_db_column(:guest_name).of_type(:string) }
    it { must have_db_column(:guest_email).of_type(:string) }
    it { must have_db_column(:admin_id).of_type(:integer) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
    it { must have_db_column(:created_at).of_type(:datetime) }
  end

  context 'LiveChat validations' do
    it { must validate_presence_of(:guest_name)}
    it { must ensure_length_of(:guest_name).is_at_least(2).is_at_most(150) }
    it { must validate_presence_of(:guest_email)}
    it { must ensure_length_of(:guest_email).is_at_least(5).is_at_most(150) }
    it { must validate_presence_of(:admin_id)}
    it { must validate_numericality_of(:admin_id).only_integer }
  end
end
