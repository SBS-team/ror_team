require 'test_helper'

describe Post do

  subject { Post.new }

  context 'Post model connection' do
    it { must belong_to(:admin).class_name('AdminUser') }
    it { must belong_to(:admin).class_name('AdminUser') }
  end

  context 'Post db column' do
    it { must have_db_column(:title).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:admin_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'Post validation' do
    it { must validate_presence_of(:title)}
    it { must ensure_length_of(:title).is_at_least(3).is_at_most(255) }
    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(10) }
    it { must validate_presence_of(:admin_id) }
    it { must validate_numericality_of(:admin_id).only_integer }
    it { must ensure_length_of(:admin_id).is_at_least(0) }
  end

end
