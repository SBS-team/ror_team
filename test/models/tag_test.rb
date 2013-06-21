require 'test_helper'

describe Tag do

  subject { Tag.new }

  context 'Tag model connection' do
    it { must have_many(:post_tags) }
    it { must have_many(:posts).through(:post_tags) }
  end

  context 'Tag db column' do
    it { must have_db_column(:name).of_type(:string) }
  end

end
