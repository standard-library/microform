require "test_helper"

class MicroformTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Microform::VERSION
  end
end
