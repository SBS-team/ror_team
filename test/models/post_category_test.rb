require 'minitest_helper'

describe PostCategory do

  subject{PostCategory.new}

  context 'PostCategory db columns' do
    it { must have_db_column(:post_id).of_type(:integer) }
    it { must have_db_column(:category_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'PostCategory relationship' do
    it { must belong_to(:post) }
    it { must belong_to(:category) }
  end

end
