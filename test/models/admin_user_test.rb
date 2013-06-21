require 'test_helper'

describe AdminUser do

  subject { AdminUser.new }

  context 'AdminUser model connection' do
    it { must have_many(:posts) }
  end

  context 'AdminUser db column' do
    it { must have_db_column(:email).of_type(:string) }
    it { must have_db_column(:encrypted_password).of_type(:string) }
    it { must have_db_column(:reset_password_token).of_type(:string) }
    it { must have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { must have_db_column(:sign_in_count).of_type(:integer) }
    it { must have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { must have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { must have_db_column(:current_sign_in_ip).of_type(:string) }
    it { must have_db_column(:last_sign_in_ip).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

end
