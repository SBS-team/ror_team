require "minitest_helper"

class ClientTestimonialTest < ActiveSupport::TestCase

  subject { ClientTestimonial.new }

  context 'model associations' do
    it { must belong_to(:project)}
  end

  context 'db columns' do
    it { must have_db_column(:comment_text).of_type(:text).with_options(null: false) }
    it { must have_db_column(:project_id).of_type(:integer).with_options(null: false) }
    it { must have_db_column(:author_name).of_type(:string).with_options(null: false) }
    it { must have_db_column(:author_position).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'validate attributes' do
    it { must validate_presence_of(:comment_text)}
    it { must ensure_length_of(:comment_text).is_at_least(5).is_at_most(2048) }

    it { must validate_presence_of(:author_name)}
    it { must validate_presence_of(:author_position)}

    it { must validate_presence_of(:project_id) }
    it { must validate_numericality_of(:project_id).only_integer }
  end
end
