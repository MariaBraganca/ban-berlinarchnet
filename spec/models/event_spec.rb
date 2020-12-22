require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "validations" do
    describe "validates start date" do
      it { should have_db_column(:start_date)  }
      it { should validate_presence_of(:start_date) }
    end

    describe "validates location" do
      it { should have_db_column(:location)  }
      it { should validate_presence_of(:location) }
    end

    describe "validates title" do
      it { should have_db_column(:title)  }
      it { should validate_presence_of(:title) }
    end

    describe "validates description" do
      # it { should have_db_column(:description)  }
      # description is being saved as an action text record into the DB
      it { should validate_presence_of(:description) }
    end

    describe "validates format" do
      it { should have_db_column(:format)  }
      it { should validate_presence_of(:format) }
    end
  end

  describe "an event" do
    let(:user) { User.create(first_name: 'Walter', last_name: 'Gropius', email: 'waltergropius@gmail.com', password: '123456') }

    subject { Event.new(user_id: user.id, start_date: Date.new(2020, 12, 17), location: 'Gropiusallee 38, 06846 Dessau-Roßlau', title: 'Bauhaus', description: 'Exkursion to the Bauhaus school in Dessau.', format: '<·banwalks') }

    it "is valid and an instance of the Event class" do
      expect(subject).to be_valid & be_an_instance_of(Event)
    end

    it "responds and has attributes" do
      # pending("issues with action text for description")
      expect(subject).to have_attributes(user_id: user.id, start_date: Date.new(2020, 12, 17), location: 'Gropiusallee 38, 06846 Dessau-Roßlau', title: 'Bauhaus', format: '<·banwalks')
    end

    it "knows if it is an upcoming event" do
      expect{ subject.start_date = 1.month.from_now }.to change(subject, :next?).from(false).to(true)
    end
  end
end
