require 'minitest_helper'

describe ApplicationController do
  ApplicationController.skip_before_filter :assign_gon_properties

end