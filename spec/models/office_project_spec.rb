require 'rails_helper'

RSpec.describe OfficeProject, type: :model do
  describe "validations" do
    describe "validates project_name" do
      it { should have_db_column(:project_name)  }
      it { should validate_presence_of(:project_name) }
    end
  end
end
