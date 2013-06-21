#require 'test_helper'

=begin
describe PostTag do

  subject { PostTag.new }

  context 'PostTag model connection' do
    it { must belong_to(:post) }
    it { must belong_to(:tag) }
  end


  context 'PostTag db column' do
    it { must have_db_column(:name).of_type(:string) }
  end


end
=end
