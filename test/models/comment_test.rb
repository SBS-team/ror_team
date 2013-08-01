require 'minitest_helper'

describe Comment do

  subject { Comment.new }

  context 'Comment model connection' do
    it { must belong_to(:commentable)}
    it { must belong_to(:post)}
  end

  context 'Comment db column' do
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:post_id).of_type(:integer) }
    it { must have_db_column(:commentable_id).of_type(:integer) }
    it { must have_db_column(:commentable_type).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

end
