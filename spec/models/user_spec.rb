require 'spec_helper'
require 'fileutils'

describe User do
  before do
    @user = User.new(first_name: 'First', last_name: 'Last',
                     email: 'user@example.com', suit_size: 'M',
                     shirt_size: 'M', password: 'foobar77',
                     password_confirmation: 'foobar77', account_id: 1,
                     location_id: 1, position_id: 1)
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:active) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:date_of_hire) }
  it { should respond_to(:sex) }
  it { should respond_to(:nickname) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:employee_id) }
  it { should respond_to(:address1) }
  it { should respond_to(:address2) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:suit_size) }
  it { should respond_to(:femalesuit) }
  it { should respond_to(:emergency_first) }
  it { should respond_to(:emergency_last) }
  it { should respond_to(:emergency_phone) }
  it { should respond_to(:payrate) }
  it { should respond_to(:grouping) }
  it { should respond_to(:shirt_size) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:admin) }
  it { should respond_to(:account_id) }
  it { should respond_to(:location) }
  it { should respond_to(:position) }
  it { should respond_to(:avatar) }
  it { should respond_to(:notes) }
  it { should respond_to(:phone_number) }

  it { should be_valid }
  it { should_not be_admin }

  describe 'with admin attribute set to \'true\'' do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe 'when password is too short' do
    before { @user.password = 'foo' }
    it { should_not be_valid }
  end

  describe 'when first name is not present' do
    before { @user.first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when preferred name is not present' do
    before { @user.nickname = ' ' }
    it { should be_valid }
  end

  describe 'when last name is not present' do
    before { @user.last_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when first name is too long' do
    before { @user.first_name = 'a' * 16 }
    it { should_not be_valid }
  end

  describe 'when last name is too long' do
    before { @user.last_name = 'a' * 26 }
    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end

  describe 'when password doesn\'t match confirmation' do
    before do
      @user.password = 'hellomynameis'
      @user.password_confirmation = 'mismatch'
    end
    it { should_not be_valid }
  end

  describe 'with a password that\'s too short' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should_not be_valid }
  end

  describe 'when account id is not present' do
    before { @user.account_id = ' ' }
    it { should_not be_valid }
  end

  describe 'user avatar' do
    context 'on user creation' do
      it 'should use the default url' do
        @user.avatar.url.should == '/images/missing.png'
      end
    end

    context 'adding an avatar' do
      before do
        upload_file = ActionDispatch::Http::UploadedFile.new(
          filename: 'avatar.jpg',
          content_type: 'image/jpeg',
          tempfile: File.new(File.join(Rails.root, 'spec/support/avatar.jpg')))

        @user.update_attribute(:avatar, upload_file)
      end

      after do
        FileUtils.rm_r(File.expand_path('../../..', @user.avatar.path))
      end

      it 'should use the correct url' do
        path_regex =
          %r{^\/system\/avatars\/\d+\/original\/avatar.jpg\?\d{10}$}

        @user.avatar.url.should match(path_regex)
      end
    end
  end
end
