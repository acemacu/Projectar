require 'test_helper'

class CsvImportControllerTest < ActionController::TestCase
  test "should get csv_import" do
    get :csv_import
    assert_response :success
  end

end
