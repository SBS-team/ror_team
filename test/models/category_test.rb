require 'minitest_helper'

describe Category do

  subject { Category.new }

  context 'Category model connection' do
    it { must have_many(:post_categories) }
    it { must have_many(:posts).through(:post_categories) }
  end

  context 'Category db column' do
    it { must have_db_column(:name).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'Category validation' do
    it { must validate_presence_of(:name)}
    it { must validate_uniqueness_of(:name)}
  end

end

