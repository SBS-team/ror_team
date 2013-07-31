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
end