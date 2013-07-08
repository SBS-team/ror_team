require 'minitest_helper'

#class AuthenticationsHelperTest < ActionView::TestCase
describe PostsHelper do

  before do
    admin = FactoryGirl.create(:admin_user)
    @posts = Array.new
    3.times do |i|
     @posts[i] = FactoryGirl.create(:post, :admin_id => admin.id, :upload_files => [FactoryGirl.create(:upload_file)])
    end
  end
  it "test f(x) relev_tags" do
    @posts[0].tag_list = 'tag1'
    @posts[0].save
    @posts[1].tag_list = 'tag1, tag2, tag3'
    @posts[1].save
    @tags = Post.tag_counts_on(:tags)
    assert_equal(relev_tags, 2)
  end
end
