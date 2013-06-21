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
    it {must validate_presence_of(:title)}
    it {must validate_presence_of(:description)}
  end

end
