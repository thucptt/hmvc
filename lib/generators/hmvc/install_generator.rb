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
        template "application_operation.rb", "app/operations/application_operator.rb"
      end

      def copy_application_form
        template "application_form.rb", "app/forms/application_form.rb"
      end

      private

      def add_comment_timestamp
        "# Created at: #{Time.now.strftime("%Y-%m-%d %H:%M %z")}"
      end

      def add_comment_creator
        "# Creator: #{`git config user.email`}"
      end
    end
  end
end
