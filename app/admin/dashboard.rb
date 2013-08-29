ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{I18n.t('active_admin.dashboard')}

  content title: proc{I18n.t('active_admin.dashboard')} do
    columns do
      column do
        panel 'Tags cloud' do
          tag_cloud(Post.tag_counts_on(:tags).select(:name).order('count DESC').limit(20), %w(cloud-tag1 cloud-tag2 cloud-tag3 cloud-tag4 cloud-tag5)) do |tag, css_class|
            span link_to tag.name , admin_posts_path(tag_name: tag.name), class: css_class
          end
        end
      end
    end
    columns do
      column do
        panel 'Last 10 Coments' do
          table_for Comment.includes(:post).order('created_at desc').limit(10) do
            column('Author')   { |com| com.nickname }
            column('Description')   { |com| com.description }
            column('Post') { |com| link_to com.post.title, admin_post_path(com.post) }
            column('Basic action') { |com| link_to 'Delete', admin_comment_path(com), method: :delete }
          end
        end
      end
      column do
        panel 'Recent Tecnologies' do
          table_for Technology.includes(:technology_category, :upload_file).order('created_at desc').limit(10) do
            column('Image'){ |tech| image_tag(tech.upload_file.img_name.url, height: 30) }
            column('Name')    { |tech| tech.name }
            column('Category'){ |tech| tech.technology_category.name}
          end
        end
      end
    end
  end

end
