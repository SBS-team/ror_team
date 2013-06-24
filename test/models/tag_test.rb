require 'test_helper'

describe Tag do

  subject { Tag.new }

  context 'Tag db column' do
    it { must have_db_column(:name).of_type(:string) }
  end

end
