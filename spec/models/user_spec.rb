require 'rails_helper'

RSpec.describe User, type: :model do

  # subject(:user) { FactoryGirl.build(:user) }

  # describe 'validations' do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  # end

  describe 'password_encryption' do

    it 'does not store a password to the database' do
      User.create(username: 'Jack Johnson', password: '123456')
      user = User.find_by(username: 'Jack Johnson')
      expect(user.password).not_to be('123456')
    end

    it 'uses BCrypt encryption to store a password digest' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: 'Jack Johnson', password: '123456')
    end
  end

  describe 'session token' do

    it 'assigns a session token if one isn\'t given' do
      user = User.create(username: 'Jack Johnson', password: '123456')
      expect(user.session_token).not_to be_nil
    end
  end

end
