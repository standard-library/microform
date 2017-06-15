require 'test_helper'
require 'minitest/mock'

class Microform::SubmissionTest < ActiveSupport::TestCase
  setup do
    @subject =  Object.new.extend(Microform::Submission)
  end

  test "should submit a form with a record and parameters" do
    record = :record
    params = {}
    form = Minitest::Mock.new
    form.expect :new, form, [record]
    form.expect :submit, record, [params]

    @subject.submit(form, record, params)

    assert_mock form
  end
end
