xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "RoR-Team blog"
    xml.description "A blog about software and chocolate"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        description_data = post.description.truncate(200)
        xml.description description_data
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link special_post_path(post.created_at.strftime('%d-%m-%Y'), post)
        xml.guid special_post_path(post.created_at.strftime('%d-%m-%Y'), post)
      end
    end
  end
end