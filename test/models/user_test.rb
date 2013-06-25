require 'minitest_helper'

describe User do

  subject { User.new }

  context 'User db columns' do
    it { must have_db_column(:email).of_type(:string).with_options(:default => "", :null => false) }
    it { must have_db_column(:encrypted_password).of_type(:string).with_options(:default => "", :null => false)}
    it { must have_db_column(:reset_password_token).of_type(:string)}
    it { must have_db_column(:reset_password_sent_at).of_type(:datetime)}
    it { must have_db_column(:remember_created_at).of_type(:datetime)}
    it { must have_db_column(:sign_in_count).of_type(:integer).with_options(:default => 0)}
    it { must have_db_column(:current_sign_in_at).of_type(:datetime)}
    it { must have_db_column(:last_sign_in_at).of_type(:datetime)}
    it { must have_db_column(:current_sign_in_ip).of_type(:string)}
    it { must have_db_column(:last_sign_in_ip).of_type(:string)}
    it { must have_db_column(:first_name).of_type(:string).with_options(:limit => 70)}
    it { must have_db_column(:last_name).of_type(:string).with_options(:limit => 70)}
    it { must have_db_column(:phone).of_type(:string).with_options(:limit => 70)}
    it { must have_db_column(:skype).of_type(:string).with_options(:limit => 70)}
    it { must have_db_column(:created_at).of_type(:datetime)}
    it { must have_db_column(:updated_at).of_type(:datetime)}
  end

  context 'User relationship' do
    it {must have_many(:comments).dependent(:destroy)}
    it {must have_many(:resumes)}
    it {must have_many(:jobs).through(:resumes)}
  end

end

