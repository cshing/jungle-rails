require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with all 5 valid attributes" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save!

      expect(@user).to be_valid
    end

    it "is not valid without a first name" do
      @user = User.new(first_name: nil, last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "is not valid without a last name" do
      @user = User.new(first_name: 'Alice', last_name: nil, email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "is not valid without an email" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: nil, password: '12345678', password_confirmation: '12345678')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid without a password" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: nil, password_confirmation: '12345678')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "is not valid if password and password_confirmation don't match" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '11111111')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "is not valid without a unique / unused email" do
      @user1 = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user1.save
      @user2 = User.new(first_name: 'Alice', last_name: 'Lee', email: 'ALICE@example.com', password: '12345678', password_confirmation: '12345678')
      @user2.save

      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "is not valid if password length is shorter than 8 characters" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '1234', password_confirmation: '1234')
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)", "Password confirmation is too short (minimum is 8 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it "should authenticate if email and password match an existing user info in database" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save!

      expect(@user.authenticate_with_credentials('alice@example.com', '12345678')).to eql(@user)
    end

    it "should not authenticate if email and password don't match an existing user info in database" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save!

      expect(@user.authenticate_with_credentials('alice@example.com', '11111111')).to_not eql(@user)
    end

    it "should still authenticate if email contains spaces before and/or after email address" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save!

      expect(@user.authenticate_with_credentials('  alice@example.com  ' , '12345678')).to eql(@user)
    end

    it "should still authenticate if email is in the wrong case" do
      @user = User.new(first_name: 'Alice', last_name: 'Lee', email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
      @user.save!

      expect(@user.authenticate_with_credentials('AlICe@exAMple.com' , '12345678')).to eql(@user)
    end

  end

end
