# annotate
class Resume < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  validates :decription,
            :presence => true,
            :length => { :minimum => 5, :maximum => 1000 }
  validates :user_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
  validates :job_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
end
