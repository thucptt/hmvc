# frozen_string_literal: true

Hmvc.setup do |config|
  # Automatically create the form files when you run the generate command. Default is true
  # config.auto_create_form = true

  # Method when creating the form files. Default is %w[new create edit update]
  # config.form_actions = %w[new create edit update]

  # The form files's parent class. Default is ApplicationForm
  # config.parent_form = "ApplicationForm"

  # The operation files's parent class. Default is ApplicationOperation
  # config.parent_operation = "ApplicationOperation"

  # The controller files's parent class of controller. Default is ApplicationController
  # config.parent_controller = "ApplicationController"

  # Method when creating the controller files. Default is %w[index show new create edit update destroy]
  # config.controller_actions = %w[index show new create edit update destroy]

  # Save author name. Default is true
  # config.author_comment = true
end