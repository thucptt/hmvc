# frozen_string_literal: true

class HmvcGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  class_option :action_controller, type: :array,   default: Hmvc.configuration.action_controller, aliases: "--ac"
  class_option :action_form,       type: :array,   default: Hmvc.configuration.action_form,       aliases: "--af"
  class_option :parent_controller, type: :string,  default: Hmvc.configuration.parent_controller, aliases: "--pc"
  class_option :parent_operation,  type: :string,  default: Hmvc.configuration.parent_operation,  aliases: "--po"
  class_option :parent_form,       type: :string,  default: Hmvc.configuration.parent_form,       aliases: "--pf"
  class_option :skip_form,         type: :boolean, default: false,                                aliases: "--sf"
  class_option :skip_view,         type: :boolean, default: false,                                aliases: "--sv"

  def create_controller
    template "controller.rb", File.join("app/controllers/#{class_path.join("/")}", "#{file_name}_controller.rb")
  end

  def create_operation
    options[:action_controller].each do |action|
      @action = action
      template "operation.rb", File.join("app/operations/#{file_path}", "#{action}_operator.rb")
    end
  end

  def create_form
    return if options[:skip_form] || !Hmvc.configuration.auto_create_form

    (options[:action_form] & options[:action_controller]).each do |action|
      @action = action
      template "form.rb", File.join("app/forms/#{file_path}", "#{action}_form.rb")
    end
  end

  def create_view
    return if options[:skip_view]

    view_engine = Rails.application.config.generators.options.dig(:rails, :template_engine) || "erb"
    (Hmvc.configuration.action_view & options[:action_controller]).each do |action|
      @action = action
      template "view.#{view_engine}", File.join("app/views/#{file_path}", "#{action}.html.#{view_engine}")
    end
  end

  private

  def path_notes(action)
    url = "#{class_path.join("/")}/#{file_name}"
    case action
    when "index"   then "# [GET] #{url}"
    when "show"    then "# [GET] #{url}/:id"
    when "new"     then "# [GET] #{url}/new"
    when "edit"    then "# [GET] #{url}/:id/edit"
    when "create"  then "# [POST] #{url}"
    when "update"  then "# [PUT] #{url}/:id"
    when "destroy" then "# [DELETE] #{url}/:id"
    else "# [METHOD] #{url}/..."
    end
  end

  def add_file_traces
    return unless Hmvc.configuration.file_traces

    "# Created at: #{Time.now.strftime("%Y-%m-%d %H:%M %z")}\n# Creator: #{`git config user.email`}"
  end
end
