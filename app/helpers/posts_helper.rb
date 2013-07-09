module PostsHelper
  include ActsAsTaggableOn::TagsHelper

  #кол-во раз, сколько встречается самый частый тег
  def relev_tags
    max_freq = 0
    @tags.each do |tag|
      max_freq = tag.count if max_freq < tag.count
    end
    max_freq
  end

  def show_categories?
    count_posts_with_category = 0
    @categories.each do |category|
      count_posts_with_category += category.posts.count
    end
    count_posts_with_category > 0 ? true : false
  end
end