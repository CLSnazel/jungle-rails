require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    context "all valid fields" do

    end

    context "missing fields" do
      it "should fail without a first name" do

      end

      it "should fail without a last name" do

      end

      it "should fail without a email" do

      end

      it "should fail without a password" do

      end

      it "should fail without a password confirmation" do

      end
    end

    context "min password length" do
      it "should fail with a password smaller than 5 characters" do

      end
    end

    context "duplicate email" do
      it "should fail with same exact email" do

      end

      it "should fail with same email w/ different case" do

      end
    end
  end

  describe '.authenticate_with_credentials' do
    context "valid user credentials" do
      it "should successfully login" do

      end
    end

    context "invalid user credentials" do
      it "should fail with a bad password" do

      end

      it "should fail with the wrong email" do

      end
    end
  end
end
