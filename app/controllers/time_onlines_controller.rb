class TimeOnlinesController < ApplicationController

  def set_time
    if current_admin_user
      unless session[:time_online].blank?
        if (DateTime.now.to_i - session[:time_online].to_i) >= (9*60)
          time_online = TimeOnline.find_or_create_by(admin_user_id: current_admin_user.id, day: DateTime.now)
          time_online.time = time_online.time.to_i + 10
          time_online.save
          session[:time_online] = DateTime.now.to_i
          return render nothing: true
        end
      else
        session[:time_online] = DateTime.now.to_i
        time_online = TimeOnline.find_or_create_by(admin_user_id: current_admin_user.id, day: DateTime.now)
        time_online.time = time_online.time.to_i + 10
        time_online.save
        return render nothing: true
      end
    end
    render nothing: true
  end

end