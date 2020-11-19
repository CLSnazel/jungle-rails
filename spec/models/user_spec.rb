require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class }

  describe "Validations" do
    context "all valid fields" do
      it "should successfully save new user" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        expect {new_user.save}.to change{User.count}.by(1)
      end
    end

    context "missing fields" do
      before(:each) do
        @new_user = User.new(first_name:"Bugs", last_name:"Bunny", email:"bugs@loonytunes.com", password:'supdoc', password_confirmation:'supdoc')
      end

      it "should fail without a first name" do
        @new_user.first_name = nil
        expect(@new_user).to_not be_valid
        expect(@new_user.errors.full_messages).to eq ["First name can't be blank"]
      end

      it "should fail without a last name" do
        @new_user.last_name = nil
        expect(@new_user).to_not be_valid
        expect(@new_user.errors.full_messages).to eq ["Last name can't be blank"]
      end

      it "should fail without a email" do
        @new_user.email = nil
        expect(@new_user).to_not be_valid
        expect(@new_user.errors.full_messages).to eq ["Email can't be blank"]
      end

      it "should fail without a password" do
        @new_user.password = nil
        expect(@new_user).to_not be_valid
        expect(@new_user.errors.full_messages).to eq ["Password can't be blank"]
      end

      it "should fail without a password confirmation" do
        @new_user.password_confirmation = nil
        expect(@new_user).to_not be_valid
        expect(@new_user.errors.full_messages).to eq ["Password confirmation can't be blank"]
      end
    end

    context "min password length" do
      it "should fail with a password smaller than 5 characters" do
        new_user = User.new(first_name:'Clementine', last_name:'Clemens', email:"tine@oranges.org", password:"meow", password_confirmation:'meow')
        expect(new_user).to_not be_valid
        expect(new_user.errors.full_messages).to eq ["Password is too short (minimum is 5 characters)"]
      end
    end

    context "duplicate email" do
      it "should fail with same exact email" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save

        duplicate_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        expect(duplicate_user).to_not be_valid
        expect(duplicate_user.errors.full_messages).to eq ["Email already registered"]
        expect {duplicate_user.save}.to_not change{User.count}
      end

      it "should fail with same email w/ different case" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save

        duplicate_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"BBLES@PPG.com", password:"unicorn", password_confirmation:"unicorn")
        expect(duplicate_user).to_not be_valid
        expect(duplicate_user.errors.full_messages).to eq ["Email already registered"]
        expect {duplicate_user.save}.to_not change{User.count}
      end

    end
  end

  describe '.authenticate_with_credentials' do
    context "valid user credentials" do
      it "should successfully login" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save
        auth_user = User.authenticate_with_credentials("bbles@ppg.com", "unicorn")
        expect(new_user).to eq auth_user
      end

      it "should successfully login with email typed in different case" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save
        auth_user = User.authenticate_with_credentials("BBLES@ppg.com", "unicorn")
        expect(new_user).to eq auth_user
      end
    end

    context "invalid user credentials" do
      it "should fail with a bad password" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save
        auth_user = User.authenticate_with_credentials("bbles@ppg.com", "stars")
        expect(auth_user).to eq nil
      end

      it "should fail with the wrong email" do
        new_user = User.new(first_name:"Bubbles", last_name:"Utonium", email:"bbles@ppg.com", password:"unicorn", password_confirmation:"unicorn")
        new_user.save
        auth_user = User.authenticate_with_credentials("bbles445@ppg.com", "unicorn")
        expect(auth_user).to eq nil
      end
    end
  end
end