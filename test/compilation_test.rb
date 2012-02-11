require 'test_helper'

class MinispadeTest < ActionController::IntegrationTest

  test "asset pipeline should serve template" do
    get "/assets/foo/test.js"
    assert_response :success
    assert @response.body == "minispade.register(\"foo/test\", \"alert(\\\"foo\\\");\\n\");\n", "Was: #{@response.body.inspect}"
  end

end
