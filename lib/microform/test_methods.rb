require "minitest/stub_any_instance"
require "minitest/mock"

module Microform
  module TestMethods
    def assert_submits form_kind, stub: nil, &block
      controller = self.class.name.gsub(/Test\z/, "").constantize
      form = form_kind.new OpenStruct.new(foo: :bar)

      # Mangle the variable names to circumvent any issues with method
      # collisions when the `submit` lambda is instance eval'ed within
      # the controller.
      __microform_form_kind = form_kind
      __microform_test = self
      __microform_stub = stub

      submit = -> f, *args {
        __microform_test.assert_equal __microform_form_kind, f

        if __microform_stub
          __microform_stub
        else
          __minitest_any_instance_stub__submit f, *args
        end
      }

      controller.stub_any_instance :submit, submit do
        yield form
      end
    end

    class ValidForm
      def initialize(*)
      end

      def valid?
        true
      end
    end

  end
end
