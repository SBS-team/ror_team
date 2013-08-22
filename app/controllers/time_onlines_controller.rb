class TimeOnlinesController < ApplicationController

  def set_time
    if current_admin_user && current_admin_user.last_activity
      if (DateTime.now.to_i - current_admin_user.last_activity.to_i) >= (9*60)
        time_online = TimeOnline.find_or_create_by(admin_user_id: current_admin_user.id, day: DateTime.now)
        time_online.time = time_online.time.to_i + 10
        time_online.save
        current_admin_user.update_attribute(:last_activity, DateTime.now)
      end
    else
      current_admin_user.update_attribute(:last_activity, DateTime.now)
      time_online = TimeOnline.find_or_create_by(admin_user_id: current_admin_user.id, day: DateTime.now)
      time_online.time = time_online.time.to_i + 10
      time_online.save
    end
    render nothing: true
  end

end