require 'test_helper'

describe ProjectService do

  subject { ProjectService.new }
  describe "db columns" do
    it { must have_db_column(:id).of_type(:integer) }
    it { must have_db_column(:project_id).of_type(:integer) }
    it { must have_db_column(:service_id).of_type(:integer) }

    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  describe "associations" do
    it { must belong_to(:project) }
    it { must belong_to(:service) }
  end


end
