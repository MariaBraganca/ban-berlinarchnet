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
  end

  describe "an user" do
    subject { User.new(first_name: 'harry', last_name: 'potter', email: 'harrypotter@gmail.com', password: '123456') }
    # let(:user) { User.new(first_name: 'Harry', last_name: 'Potter', email: 'harrypotter@gmail.com', password: '123456') }

    it "is valid and an instance of the User class" do
      expect(subject).to be_valid & be_an_instance_of(User)
    end

    it "has and responds to attributes" do
      expect(subject).to have_attributes(
        first_name: 'harry',
        last_name: 'potter',
        email: 'harrypotter@gmail.com',
        password: '123456')
    end

    it "retrieves a full name" do
      expect(subject.full_name).to eq('Harry Potter')
    end
  end
end
