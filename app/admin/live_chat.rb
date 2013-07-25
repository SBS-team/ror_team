ActiveAdmin.register LiveChat do

  filter :admin_id, :as => :select
  filter :guest_email

  action_item do
    link_to 'Start chat', admin_start_chat_path, :target => '_blank'
  end

  index do
    selectable_column
    column :guest_name
    column :guest_email
    column :admin_id
    column :created_at
    default_actions
  end

  show do |live_chat|
    panel 'Chat Details' do
      attributes_table_for live_chat do
        row :guest_name
        row :guest_email
        row :admin_id
        row :created_at
        row :created_at
        row :updated_at
      end
    end
    unless live_chat.chat_messages.blank?
      panel "Chat massage (#{live_chat.chat_messages.count})" do
        live_chat.chat_messages.each do |msg|
          div do
            span do msg.is_admin ? 'Admin:' : 'User:' end
            span do msg.body end
          end
        end
      end
    end
  end

end
