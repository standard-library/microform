require "test_helper"
require "microform/test_methods"

class TestMethodsTest < Minitest::Test
  def test_asserts_controller_submits_correct_form
    runner = FooControllerTest.new :foo
    assert_raises MiniTest::Assertion do
      runner.assert_submits FooForm do
        FooController.new.submit BarForm, Foo.new("hi"), {}
      end
    end
  end

  def test_returns_original_form_from_submission
    runner = FooControllerTest.new :foo
    runner.assert_submits FooForm do
      form = FooController.new.submit FooForm, Foo.new("hi"), {}
      assert_kind_of FooForm, form
    end
  end

  def test_returns_stubbed_value
    runner = FooControllerTest.new :foo
    stub = FormStub.new

    runner.assert_submits FooForm, stub: stub do
      form = FooController.new.submit FooForm, Foo.new("hi"), {}
      assert_equal stub, form
    end
  end

  class FooControllerTest < Minitest::Test
    include Microform::Test::IntegrationMethods
  end

  class FooController
    def submit form_kind, record, params
      form_kind.new record
    end
  end

  class FooForm
    def initialize record
    end

    def submit form_kind, record, *args
      form_kind.new record
    end
  end

  class BarForm
    def initialize record
    end

    def submit *args
    end
  end

  class FormStub
  end

  Foo = Struct.new(:title)
end
