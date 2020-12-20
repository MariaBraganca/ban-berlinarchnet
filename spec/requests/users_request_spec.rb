require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "user management" do
    it "renders index" do
      get '/users'
      expect(response).to render_template(:index)
    end
  end

end
