require 'minitest_helper'

describe Post do

  subject { Post.new(:upload_file => UploadFile.new) }

  context 'Post db columns' do
    it { must have_db_column(:title).of_type(:string) }
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:admin_user_id).of_type(:integer) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
    it { must have_db_column(:comments_count).of_type(:integer) }
  end

  context 'Post relationship' do
    it { must belong_to(:admin_user) }
    it { must have_many(:post_categories).dependent(:destroy) }
    it { must have_many(:categories).through(:post_categories) }
    it { must have_many(:comments).dependent(:destroy) }
    it { must have_one(:upload_file).dependent(:destroy) }
  end

  context 'Post validations attributes' do
    it { must validate_presence_of(:title)}
    it { must ensure_length_of(:title).is_at_least(3).is_at_most(255) }

    it { must validate_presence_of(:description) }
    it { must ensure_length_of(:description).is_at_least(10) }

    it { must validate_presence_of(:admin_user_id) }
    it { must validate_numericality_of(:admin_user_id).only_integer }
    it { must ensure_length_of(:admin_user_id).is_at_least(0) }
  end

  context 'Post search' do
    it 'search' do
      admin = FactoryGirl.create(:admin_user)
      post_1 = FactoryGirl.create(:post, :title => 'Post my_search', :admin_user_id => admin.id, :upload_file => FactoryGirl.create(:upload_file))
      post_2 = FactoryGirl.create(:post, :admin_user_id => admin.id, :upload_file => FactoryGirl.create(:upload_file))

      Post.all.count.must_equal 2

      post = Post.search_posts_based_on_like 'my_search'
      post.must_include post_1
      post.wont_include post_2

      post = Post.search_posts_based_on_like false
      post.must_include  post_1, post_2
    end
  end

end
