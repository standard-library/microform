require 'test_helper'
require 'generators/microform/form/form_generator'
require 'rails/generators/test_case'

class FormGeneratorTest < Rails::Generators::TestCase
  tests Microform::FormGenerator
  destination 'tmp/generators'
  setup :prepare_destination

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator ["test"]
    end
  end
end
