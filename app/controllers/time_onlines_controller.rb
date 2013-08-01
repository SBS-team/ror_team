class TimeOnlinesController < ApplicationController

  def set_time
    unless current_admin_user.nil?
      time_online = TimeOnline.find_or_create_by(:admin_id => current_admin_user.id, :day => DateTime.now)
      time_online.time = time_online.time.to_i + 10
      time_online.save

      render :text => '+10'
    end
  end

end