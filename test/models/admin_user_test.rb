require 'minitest_helper'

describe AdminUser do

  subject { AdminUser.new }

  context 'AdminUser model connection' do
    it { must have_many(:posts).dependent(:destroy) }
    it { must have_many(:comments).dependent(:destroy) }
    it { must have_many(:time_onlines) }
    it { must have_one(:upload_file) }
  end

  context 'AdminUser db column' do
    it { must have_db_column(:email).of_type(:string) }
    it { must have_db_column(:encrypted_password).of_type(:string) }
    it { must have_db_column(:reset_password_token).of_type(:string) }
    it { must have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { must have_db_column(:remember_created_at).of_type(:datetime) }
    it { must have_db_column(:sign_in_count).of_type(:integer) }
    it { must have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { must have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { must have_db_column(:current_sign_in_ip).of_type(:string) }
    it { must have_db_column(:last_sign_in_ip).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
    it { must have_db_column(:role).of_type(:string) }
    it { must have_db_column(:about).of_type(:text) }
    it { must have_db_column(:first_name).of_type(:string) }
    it { must have_db_column(:last_name).of_type(:string) }
    it { must have_db_column(:last_activity).of_type(:datetime) }
    it { must have_db_column(:busy).of_type(:boolean) }
  end

  context 'AdminUser validation' do
    it { must validate_presence_of(:email) }
    it { must validate_uniqueness_of(:email) }
    it { must validate_presence_of(:password_confirmation) }
    it { must validate_presence_of(:password) }
    it { must validate_presence_of(:role) }
    it { must ensure_inclusion_of(:role).in_array(['admin', 'manager', 'team_lead', 'team']) }
    it { must validate_presence_of(:first_name) }
    it { must ensure_length_of(:first_name).is_at_least(3).is_at_most(45) }
    it { must validate_presence_of(:last_name) }
    it { must ensure_length_of(:last_name).is_at_least(3).is_at_most(45) }
    it { must validate_presence_of(:about) }
    it { must ensure_length_of(:about).is_at_least(10) }
  end

end