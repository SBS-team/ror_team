require 'minitest_helper'

describe Advantage do

  subject { Advantage.new }

  context 'Advantage model connection' do
    it { must have_one(:upload_file) }
  end

  context 'Advantage db column' do
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'Advantage validation' do
    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(3).is_at_most(255) }
  end

end