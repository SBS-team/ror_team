require 'minitest_helper'

describe PostsController do

  before do
    @admin = FactoryGirl.create(:admin_user)
  end

  describe 'GET #index' do

    before do
      @posts = []
      5.times do
        post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
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
      2.times do
        post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
        @posts << post
      end
      get :index
      refute_nil assigns(:posts)
      assert_includes(assigns(:posts), @posts[6])
      assert_includes(assigns(:posts), @posts[2])
      refute_includes(assigns(:posts), @posts[1])
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

    it 'search post' do
      post = FactoryGirl.create(:post, :title => 'Post search', :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      get :index, :search => 'search'
      assert_includes(assigns(:posts), post)
      refute_includes(assigns(:posts), @posts[0])
      get :index, :search => 'Coverage'
      assigns(:posts).must_be_empty
      get :index, :search => 'Coverage Coverage Coverage Coverage Coverage Coverage Coverage'
      assigns(:posts).must_be_empty
    end

    it 'Comments load' do
      post1 = FactoryGirl.create(:post, :title => 'Post search', :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      post1.comments << FactoryGirl.create(:comment) << FactoryGirl.create(:comment) << FactoryGirl.create(:comment) << FactoryGirl.create(:comment)
      post :comments_show_all, :id => post1.id
      assert_response :ok
    end

  end

  describe 'GET #show' do

    it 'rendering' do
      post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      get :show, created: post.created_at.strftime('%d-%m-%Y') , id: post
      assert_template :show
      assert_template layout: "layouts/application"
    end

    it "show recents posts" do
      posts = []
      6.times do
        post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
        posts << post
      end

      get :show, created: posts[0].created_at.strftime('%d-%m-%Y') , id: posts[0]
      refute_nil assigns(:recent_posts)
      assert_includes(assigns(:recent_posts), posts[5])
      assert_includes(assigns(:recent_posts), posts[4])
      assert_includes(assigns(:recent_posts), posts[3])
      assert_includes(assigns(:recent_posts), posts[2])
      assert_includes(assigns(:recent_posts), posts[1])
      refute_includes(assigns(:recent_posts), posts[0])
    end

    it "show popular posts" do
      post1 = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      post2 = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      post3 = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))

      get :show, created: post2.created_at.strftime('%d-%m-%Y') , id: post2

      refute_nil assigns(:popular_posts)
      pop_posts = assigns(:popular_posts)
      pop_posts.must_include post1
      pop_posts.must_include post2
      pop_posts.must_include post3
    end
  end

  describe 'side_bar; all actions' do
    it 'show all categories' do
      post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      cat1 = FactoryGirl.create(:category)
      cat2 = FactoryGirl.create(:category)
      post.categories << cat1 << cat2
      post.save

      get :index
      refute_nil assigns(:categories)
      assert_includes(assigns(:categories), cat1)
      assert_includes(assigns(:categories), cat2)
    end

    it 'show all tags' do
      post = FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      post.tag_list = "tag1, tag2, tag3"
      post.save

      get :index
      refute_nil assigns(:tags)
      tags = assigns(:tags)
      tags.size.must_equal 3
      "tag1, tag2, tag3".must_include tags[0].name
      "tag1, tag2, tag3".must_include tags[1].name
      "tag1, tag2, tag3".must_include tags[2].name
    end
  end
end

