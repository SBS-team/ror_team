require 'minitest_helper'

describe TeamPhoto do

  subject { TeamPhoto.new }

  context 'TeamPhoto db columns' do
    it { must have_db_column(:title).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'TeamPhoto relationship' do
    it { must have_many(:upload_files).dependent(:destroy)}
  end

  context 'TeamPhoto validations attributes' do
    it { must validate_presence_of(:title)}
    it { must validate_uniqueness_of(:title) }
    it { must ensure_length_of(:title).is_at_least(5).is_at_most(100) }
    it { must validate_presence_of(:upload_files)}
  end

end
