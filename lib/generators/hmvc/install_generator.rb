# frozen_string_literal: true

module Hmvc
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Generate base files of the HMVC structure."

      source_root File.expand_path("templates", __dir__)

      def copy_initializers_config
        template "hmvc.rb", "config/initializers/hmvc.rb"
      end

      def copy_application_operator
        template "application_operator.rb", "app/operators/application_operator.rb"
      end

      def copy_application_form
        template "application_form.rb", "app/forms/application_form.rb"
      end
    end
  end
end
