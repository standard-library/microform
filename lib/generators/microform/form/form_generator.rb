require "rails/generators"
require "rails/generators/base"


module Microform
  class FormGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_form
      template "form.rb", "app/forms/#{file_name}_form.rb"
      template "form_test.rb", "test/forms/#{file_name}_form_test.rb"
    end
  end
end
