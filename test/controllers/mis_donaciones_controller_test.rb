require 'test_helper'

class MisDonacionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mis_donaciones_index_url
    assert_response :success
  end

end
