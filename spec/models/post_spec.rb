require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    describe "validates date" do
      it { should have_db_column(:date)  }
      it { should validate_presence_of(:date) }
    end

    describe "validates title" do
      it { should have_db_column(:title)  }
      it { should validate_presence_of(:title) }
    end

    describe "validates content" do
      # it { should have_db_column(:content)  }
      # content is being saved as an action text record into the DB
      it { should validate_presence_of(:content) }
    end
  end
end
