require 'test_helper'

class OfficeProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get office_projects_index_url
    assert_response :success
  end

end
