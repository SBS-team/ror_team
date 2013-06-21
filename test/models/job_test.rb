require 'test_helper'

describe Job do
  context "relationships between tables" do
    subject{Job.new}
    it {must have_many(:resumes)}
    it {must have_many(:users).through(:resumes)}
  end
  context "test db collumn" do
    it { have_db_column(:title).of_type(:string) }
    it { have_db_column(:created_at).of_type(:datetime) }
    it { have_db_column(:updated_at).of_type(:datetime) }
    it { have_db_column(:description).of_type(:text) }
  end
end
