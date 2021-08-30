require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    describe "validates date" do
      it { should have_db_column(:date)  }
      it { should validate_presence_of(:date) }
    end

    describe "validates content" do
      it { should have_db_column(:content)  }
      it { should validate_presence_of(:content) }
    end
  end
end
