ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Tags cloud" do
          tag_cloud(Post.tag_counts_on(:tags).select(:name).order('count DESC').limit(20), %w(cloud-tag1 cloud-tag2 cloud-tag3 cloud-tag4 cloud-tag5)) do |tag, css_class|
            span link_to tag.name , admin_posts_path(:tag_name => tag.name), :class => css_class
          end
        end
      end
    end
    columns do
      column do
        panel "Back-end Recent Coments" do
          table_for ActiveAdmin::Comment.order('created_at desc').limit(5) do
            column("Author")   { |com| com.author.email }
            column("Permalink"){ |com| link_to 'Here she is', polymorphic_path([:admin, com.resource])}
          end
        end
      end
      column do
        panel "Recent Tecnologies" do
          table_for Technology.order('created_at desc').limit(2) do
            column("Name")    { |tech| tech.name }
            column("Category"){ |tech| tech.technology_category.name}
          end
        end
      end
    end
  end
end
