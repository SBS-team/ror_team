class ClientTestimonial < ActiveRecord::Base
  belongs_to :project

  validates :comment_text, presence: true, length: { in: (5..2048) }
  validates :author_name, presence: true
  validates :project_id, presence: true, numericality: { only_integer: true }

  after_destroy :clear_cache

  private

  def clear_cache
    expire_fragment(self)
  end
end
