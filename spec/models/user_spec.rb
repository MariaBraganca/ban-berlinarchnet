require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    describe "validates first name" do
      it { should have_db_column(:first_name)  }
      it { should validate_presence_of(:first_name) }
    end

    describe "validates last name" do
      it { should have_db_column(:last_name)  }
      it { should validate_presence_of(:last_name) }
    end

    describe "validates email" do
      it { should have_db_column(:email)  }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    describe "validates password" do
      it { should have_db_column(:encrypted_password)  }
      it { should validate_presence_of(:encrypted_password) }
    end

    context "if valid attributes are provided" do
      it "validates user" do
        harry = User.new(
          first_name: 'Harry',
          last_name: 'Potter',
          email: 'harry.potter@gmail.com',
          password: '123456')
        harry.save

        expect(harry).to be_valid
      end
    end
  end

  context "if user is valid" do
    it "retrieves user's full name" do
      harry = User.new(
        first_name: 'harry',
        last_name: 'potter',
        email: 'harry.potter@gmail.com',
        password: '123456')
      harry.save

      expect(harry.full_name).to eq('Harry Potter')
    end
  end
end
