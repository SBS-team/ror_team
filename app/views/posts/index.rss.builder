xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "RoR-Team blog"
    xml.description "A blog about software and chocolate"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title.html_safe
        description_data = post.description.html_safe[0..200]
        description_data += "..." if post.description.length > 200
        xml.description description_data
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end