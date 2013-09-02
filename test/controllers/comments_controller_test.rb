require 'minitest_helper'

describe CommentsController do

  before do
    @admin = FactoryGirl.create(:admin_user, role: 'admin')
    @post = FactoryGirl.create(:post, title: 'my-post-comment', admin_user_id: @admin.id, upload_file: FactoryGirl.create(:upload_file))
  end

  describe 'Create comment' do

     it 'POST #create' do
       post :create, comment:{nickname: 'user', description: 'sgdgrgergeg'}, post_id: @post.slug
       assigns(:post).must_equal @post
       JSON.parse(response.body)['stat'].must_equal 'success'
       assert_response :ok


       post :create, comment:{nickname: 'admin', description: 'sgdgrgergeg'}, post_id: @post.slug
       assigns(:post).must_equal @post
       JSON.parse(response.body)['stat'].must_equal 'error'
       assert_response :ok

       sign_in @admin
       post :create, comment:{nickname: 'user', description: 'sgdgrgergeg'}, post_id: @post.slug
       assigns(:post).must_equal @post
       JSON.parse(response.body)['stat'].must_equal 'success'
       assert_response :ok
    end

  end

end

