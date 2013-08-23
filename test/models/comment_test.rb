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

  context 'Comment validations attributes' do
    it { must validate_presence_of(:description)}
    it { must ensure_length_of(:description).is_at_least(2).is_at_most(2048) }

    it { must validate_presence_of(:nickname)}
    it { must ensure_length_of(:nickname).is_at_least(2).is_at_most(40) }

    it { must validate_presence_of(:post_id) }
    it { must validate_numericality_of(:post_id).only_integer }
    it { must ensure_length_of(:post_id).is_at_least(0) }

    it 'validates_nickname' do
      comment = Comment.new(:description => 'My comment', :nickname => 'admin', :post_id => 1)
      comment.valid?.must_equal false
    end
  end

end
