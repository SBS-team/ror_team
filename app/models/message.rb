class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :text, :phone, :service_type, :work_type

  validates :name, :email, presence: true
  validates :email, format: {with: %r{.+@.+\..+}}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

end