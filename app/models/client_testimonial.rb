class ClientTestimonial < ActiveRecord::Base
  belongs_to :project

  validates :comment_text,
            presence: true
  validates :author_name,
            presence: true
  validates :project_id,
            presence: true,
            numericality: { only_integer: true }
end
