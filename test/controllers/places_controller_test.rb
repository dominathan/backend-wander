require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get places_get_url
    assert_response :success
  end

  test "should get post" do
    get places_post_url
    assert_response :success
  end

end
