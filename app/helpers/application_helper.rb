module ApplicationHelper

  def new_posts_and_jobs
    @new_posts = Post.order('updated_at desc')
    @new_jobs = Job.order('updated_at desc')
  end

end
