require 'rails_helper'

RSpec.describe Opening, type: :model do
  describe "validations" do
    describe "validates date" do
      it { should have_db_column(:date)  }
      it { should validate_presence_of(:date) }
    end

    describe "validates job_position" do
      it { should have_db_column(:date)  }
      it { should validate_presence_of(:date) }
    end

    describe "validates job_url" do
      it { should have_db_column(:job_url) }
      it { should validate_uniqueness_of(:job_url) }
    end
  end

  describe "an opening" do
    subject { Opening.new(date: Time.new(2020,10,17), job_position: 'Auror') }

    it "validates opening and is an instance of the Opening class" do
      expect(subject).to be_valid & be_an_instance_of(Opening)
    end

    it "has and responds to attributes" do
      expect(subject).to have_attributes(
        date: Time.new(2020,10,17),
        job_position: 'Auror')
    end

    it "is recent if date is not older than 1 month" do
      expect(subject.recent?).to be(false)
    end
  end
end
