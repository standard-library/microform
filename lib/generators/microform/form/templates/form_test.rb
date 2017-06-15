require "test_helper"

class <%= file_name.capitalize %>FormTest < ActiveSupport::TestCase
  test "should submit form" do
    <%= file_name %> = <%= file_name.pluralize %>(:one)
    changeset = {}
    form = <%= file_name.capitalize %>Form.new(<%= file_name %>)

    assert form.submit(changeset)
  end
end
