# == Schema Information
#
# Table name: client_testimonials
#
#  id              :integer          not null, primary key
#  comment_text    :text
#  author_name     :string(255)
#  author_position :string(255)
#  project_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class ClientTestimonial < ActiveRecord::Base
  belongs_to :project

  validates :comment_text, presence: true, length: { in: (5..2048) }
  validates :author_name, presence: true
  validates :project_id, presence: true, numericality: { only_integer: true }

end
