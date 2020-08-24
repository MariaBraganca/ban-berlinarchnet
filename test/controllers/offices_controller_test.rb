require 'test_helper'

class OfficesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get offices_index_url
    assert_response :success
  end

  test "should get show" do
    get offices_show_url
    assert_response :success
  end

end
