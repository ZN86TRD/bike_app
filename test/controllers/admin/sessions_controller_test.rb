require "test_helper"

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin/dashboards" do
    get admin_sessions_admin/dashboards_url
    assert_response :success
  end
end
