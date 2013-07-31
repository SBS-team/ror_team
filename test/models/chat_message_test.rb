require "minitest_helper"

describe ChatMessage do

  subject { ChatMessage.new }

  context 'ChatMessage model relations' do
    it { must belong_to(:live_chat) }
  end

  context 'ChatMessage db columns' do
    it { must have_db_column(:body).of_type(:text) }
    it { must have_db_column(:live_chat_id).of_type(:integer) }
    it { must have_db_column(:is_admin).of_type(:boolean) }
    it { must have_db_column(:created_at).of_type(:datetime) }
  end

  context 'ChatMessage validations' do
    it { must validate_presence_of(:body)}
    it { must validate_presence_of(:live_chat_id)}
    it { must validate_numericality_of(:live_chat_id).only_integer }
  end
end
