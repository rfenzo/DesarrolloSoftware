require 'test_helper'

class MisProyectosEmpresaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mis_proyectos_empresa_index_url
    assert_response :success
  end

end
