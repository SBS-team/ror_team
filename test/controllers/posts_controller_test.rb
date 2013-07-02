require 'minitest_helper'

describe PostsController do
  ApplicationController.skip_before_filter :assign_gon_properties

  describe 'GET #index' do

    before do
      @posts = []
      5.times do
        post = FactoryGirl.build(:post)
        post.upload_files << FactoryGirl.create(:upload_file)
        post.save
        @posts << post
      end
    end

    it 'rendering' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_response :success
    end

    it 'show posts' do
      6.times do
        post = FactoryGirl.build(:post)
        post.upload_files << FactoryGirl.create(:upload_file)
        post.save
        @posts << post
      end
      get :index
      refute_nil assigns(:posts)
      assert_includes(assigns(:posts), @posts[10])
      assert_includes(assigns(:posts), @posts[4])
      assert_includes(assigns(:posts), @posts[1])
      #т.к. пагинация по 10 страниц, то остальные не выводятся на страницу
      refute_includes(assigns(:posts), @posts[0])
    end

    it 'show posts by tag' do
      @posts[0].tag_list = "tag"
      @posts[0].save
      @posts[2].tag_list = "tag"
      @posts[2].save

      get :index, tag_name: "tag"
      refute_nil assigns(:posts)
      assert_includes(assigns(:posts), @posts[0])
      assert_includes(assigns(:posts), @posts[2])
      refute_includes(assigns(:posts), @posts[1])
      refute_includes(assigns(:posts), @posts[3])
      refute_includes(assigns(:posts), @posts[4])
    end

    it 'show posts by category' do
      category = FactoryGirl.create(:category)
      @posts[0].categories << category
      @posts[0].save
      @posts[2].categories << category
      @posts[2].save

      get :index, category_name: category.name
      refute_nil assigns(:posts)
      assert_includes(assigns(:posts), @posts[0])
      assert_includes(assigns(:posts), @posts[2])
      refute_includes(assigns(:posts), @posts[1])
      refute_includes(assigns(:posts), @posts[3])
      refute_includes(assigns(:posts), @posts[4])
    end

  end

  describe 'GET #show' do

    it 'rendering' do
      post = FactoryGirl.create(:post)
      get :show, id: post
      assert_template :show
      assert_template layout: "layouts/application"
    end

    it "show post with comments" do
      post = FactoryGirl.create(:post)
      user = FactoryGirl.create(:user)
      comment1 = FactoryGirl.create(:comment, :commentable => user)
      comment2 = FactoryGirl.create(:comment, :commentable => user)
      comment3 = FactoryGirl.create(:comment, :commentable => user)
      post.comments << comment1
      post.comments << comment2

      get :show, id: post
      refute_nil assigns(:post)
      refute_nil assigns(:comments)

      assigns(:comments).must_include(comment1, comment2)
      assigns(:comments).wont_include(comment3)
    end
  end

  describe 'side_bar; all actions' do
    it 'show all categories' do
      cat1 = FactoryGirl.create(:category)
      cat2 = FactoryGirl.create(:category)

      get :index
      refute_nil assigns(:categories)
      assert_includes(assigns(:categories), cat1)
      assert_includes(assigns(:categories), cat2)
    end

    it 'show all categories' do
      post = FactoryGirl.create(:post)
      post.tag_list = "tag1, tag2, tag3"

      get :index
      refute_nil assigns(:tags)
    end
  end
end