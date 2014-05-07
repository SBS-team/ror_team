# == Schema Information
#
# Table name: time_onlines
#
#  id            :integer          not null, primary key
#  admin_user_id :integer
#  day           :date
#  time          :integer
#

class TimeOnline < ActiveRecord::Base

  belongs_to :admin_user

end
