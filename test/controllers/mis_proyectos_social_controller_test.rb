require 'test_helper'

class MisProyectosSocialControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mis_proyectos_social_index_url
    assert_response :success
  end

end
