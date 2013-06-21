require 'test_helper'

describe Resume do
  context "relationships between tables"  do
    subject{Resume.new}
    it {must belong_to(:user)}
    it {must belong_to(:job)}
  end
  context "test db collumn" do
    it { have_db_column(:description).of_type(:text) }
    it { have_db_column(:created_at).of_type(:datetime) }
    it { have_db_column(:updated_at).of_type(:datetime) }
    it { have_db_column(:user_id).of_type(:integer) }
    it { have_db_column(:job_id).of_type(:integer) }
  end
end
