require 'test_helper'

class MinispadeTest < ActionController::IntegrationTest

  test "asset pipeline should serve template" do
    switch_deferred false

    get "/assets/foo/test.js"
    assert_response :success
    assert @response.body == "minispade.register(\"foo/test\", function() { alert(\"foo\");\n });\n", "Was: #{@response.body.inspect}"
  end

  test "asset pipeline should serve a deferred template" do
    switch_deferred true

    get "/assets/foo/test.js"
    assert_response :success
    assert @response.body == "minispade.register(\"foo/test\", \"alert(\\\"foo\\\");\\n//@ sourceURL=foo/test.js\");\n", "Was: #{@response.body.inspect}"
  end

  # This kinda sucks. If I don't do this, then the assets don't recompile when I change
  # the deferred flag.
  def switch_deferred(flag)
    MinispadeRails::Config.deferred = flag

    %x{cd test/dummy && rake assets:clean &> /tmp/null}
    Rails.application.assets.send(:expire_index!)
  end

end
