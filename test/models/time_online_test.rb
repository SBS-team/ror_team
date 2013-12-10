require 'minitest_helper'

describe TimeOnline do

  subject { TimeOnline.new }

  context 'TimeOnline db columns' do
    it { must have_db_column(:admin_user_id).of_type(:integer) }
    it { must have_db_column(:day).of_type(:date)}
    it { must have_db_column(:time).of_type(:integer)}
  end

  context 'TimeOnline relationship' do
    it { must belong_to(:admin_user) }
  end

end
