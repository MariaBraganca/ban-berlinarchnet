require 'rails_helper'

RSpec.describe Office, type: :model do
  describe "validations" do
    describe "validates name" do
      it { should have_db_column(:name)  }
      it { should validate_presence_of(:name) }
    end

    describe "validates url" do
      it { should have_db_column(:url)  }
      it { should validate_presence_of(:url) }
    end

    describe "validates location" do
      it { should have_db_column(:location)  }
      it { should validate_presence_of(:location) }
    end
  end
end
