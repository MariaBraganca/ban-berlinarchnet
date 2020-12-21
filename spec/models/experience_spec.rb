require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe "validations" do
    describe "validates start date" do
      it { should have_db_column(:start_date)  }
      it { should validate_presence_of(:start_date) }
    end

    describe "validates end date" do
      it { should have_db_column(:end_date)  }
    end

    describe "validates job position" do
      it { should have_db_column(:job_position)  }
      it { should validate_presence_of(:job_position) }
    end
  end

  describe 'an experience' do
    let(:user) { User.create(first_name: 'cornelius', last_name: 'fudge', email: 'corneliusfudge@gmail.com', password: '123456') }
    let(:office) { Office.create(name: 'British Ministery of Magic', location: 'Ministry of Magic Headquarters, London', url: 'www.ministeryofmagic.com') }

    subject { Experience.new(start_date: Date.new(2017, 1, 1), job_position: 'Minister of Magic', user_id: user.id, office_id: office.id) }

    it "is valid and an instance of the Experience class" do
      expect(subject).to be_valid & be_an_instance_of(Experience)
    end

    it "has and responds to attributes" do
      expect(subject).to have_attributes(start_date: Date.new(2017, 1, 1), job_position: 'Minister of Magic', user_id: user.id, office_id: office.id)
    end

    it "is current if the end date is not provided" do
      expect{ subject.end_date = Date.new(2020, 5, 31) }.to change(subject, :current?).from(true).to(false)
    end
  end
end
