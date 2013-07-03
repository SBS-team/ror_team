class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :text, :phone, :service_type1, :service_type2, :service_type3, :work_type

  validates :name, :email, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true #FIXME

  def initialize(attributes = {}) #FIXME
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?  #FIXME
    false
  end

end