class CareersController < ApplicationController
  def index
    @jobs = Job.all.page params[:page]
    @post = Post.all.order("created_at DESC").limit(4)
    @jobs = Job.all.order("created_at DESC").limit(4)
    @user = User.find(2)
    @resume = Resume.new
  end

  def create
    @resume = Resume.build(params[:resume])
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end


#def new
#  @post = Post.new
#  respond_to do |format|
#    format.html # index.html.erb
#  end
#end
#
## POST /posts
#def create
#  @post = current_user.posts.build(params[:post])
#  @count_user_not_confirm_posts = current_user.posts.not_confirmed.count
#  if (@count_user_not_confirm_posts<3)
#    respond_to do |format|
#      if @post.save
#        format.html { redirect_to @post, notice: 'Post was successfully created.' }
#      else
#        format.html { render action: "new" }
#      end
#    end
#  end
#end