require "microform/version"
require "generators/microform/form/form_generator"

module Microform
  module Submission
    def submit(form_kind, record, params)
      form = form_kind.new(record)
      form.submit params
      form
    end
  end
end
