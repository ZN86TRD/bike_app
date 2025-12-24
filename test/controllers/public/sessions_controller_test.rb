require "test_helper"

class Public::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get public/registrations" do
    get public_sessions_public/registrations_url
    assert_response :success
  end
end
