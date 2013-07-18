# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  about                  :text
#  first_name             :string(255)
#  last_name              :string(255)
#

class AdminUser < ActiveRecord::Base

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :posts, :dependent => :destroy, :foreign_key => :admin_id
  has_many :upload_files, :as => :fileable
  has_many :live_chats

  accepts_nested_attributes_for :upload_files

  validates :role,
            :presence => true,
            inclusion: { in: %w(admin manager team_lead team),
                                message: "%{value} is not a valid role" }
  validates :first_name,
            :presence => true,
            :length => { :minimum => 3,
                         :maximum => 45 }
  validates :last_name,
            :presence => true,
            :length => { :minimum => 3,
                         :maximum => 45 }
  validates :about,
            :presence => true,
            :length => { :minimum => 10 }

  validates :password,
            :presence => true

  validates :password_confirmation,
            :presence => true

  validates :email,
            :uniqueness => true,
            :presence => true

end
