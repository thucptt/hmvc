# frozen_string_literal: true

require_relative "hmvc/version"

module Hmvc
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :file_traces, :auto_create_form, :action_form, :parent_form,
                  :parent_operation, :parent_controller, :action_controller, :action_view

    def initialize
      @file_traces       = true
      @auto_create_form  = true
      @parent_form       = "ApplicationForm"
      @parent_operation  = "ApplicationOperation"
      @parent_controller = "ApplicationController"
      @action_view       = %w[index show new edit]
      @action_form       = %w[new create edit update]
      @action_controller = %w[index show new create edit update destroy]
    end
  end
end
