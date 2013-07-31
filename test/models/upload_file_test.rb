require 'minitest_helper'

class UploadFileTest < ActiveSupport::TestCase
  subject { UploadFile.new }
  it { must belong_to(:fileable) }
end