ActiveAdmin.register LiveChat do

  #filter :admin_id, :as => :select, :collection => AdminUser.where(:role => 'manager').map { |j| [j.email, j.id] }
  filter :created_at

  scope :mine do |live_chat|
    live_chat.where(:admin_id => current_admin_user.id)
  end

  action_item :if => proc{ current_admin_user.role == 'manager' } do
    link_to 'Start chat', admin_start_chat_path, :target => '_blank'
  end

  index do
    selectable_column
    column :guest_name
    column :admin do |live_chat|
      live_chat.admin_user.email
    end
    column :created_at
    default_actions
  end

  show do |live_chat|
    panel 'Chat Details' do
      attributes_table_for live_chat do
        row :guest_name
        row :admin do
          live_chat.admin_user.email
        end
        row :created_at
        row :updated_at
      end
    end
    unless live_chat.chat_messages.blank?
      panel "Chat massage (#{live_chat.chat_messages.count})" do
        table_for live_chat.chat_messages do |t|
          t.column 'Sender' do |msg|
            msg.is_admin ? "Admin: #{live_chat.admin_user.email}" : "User: #{live_chat.guest_name}"
          end
          t.column 'Massages' do |msg|
            msg.body
          end
          t.column 'Created at' do |msg|
            msg.created_at.strftime('%d %B %H:%M:%S')
          end
        end
      end
    end
  end

  controller do

    def scoped_collection
      LiveChat.includes([:admin_user]).page(params[:page]).per(30)
    end

  end

end