# frozen_string_literal: true

class HmvcGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  class_option :controller, type: :string, aliases: "-c"
  class_option :action, type: :string, aliases: "-a", default: "index show new edit create update destroy"

  def create_controller
    template "controller.rb", File.join("app/controllers/#{class_path.join("/")}", "#{file_name}_controller.rb")
  end

  def create_operation
    options[:action].split(" ").each do |action|
      @action = action
      template "operation.rb", File.join("app/operations/#{file_path}", "#{action}_operator.rb")
    end
  end

  def create_form
    options[:action].split(" ").each do |action|
      @action = action
      template "form.rb", File.join("app/forms/#{file_path}", "#{action}_form.rb")
    end
  end

  private

  def add_comment_endpoint(action)
    url = "#{class_path.join("/")}/#{file_name}"
    case action
    when "index" then "# [GET] #{url}"
    when "show" then "# [GET] #{url}/:id"
    when "new" then "# [GET] #{url}/new"
    when "edit" then "# [GET] #{url}/:id/edit"
    when "create" then "# [POST] #{url}"
    when "update" then "# [PUT] #{url}/:id"
    when "destroy" then "# [DELETE] #{url}/:id"
    else "# [METHOD] #{url}/..."
    end
  end

  def add_comment_timestamp
    "# Created at: #{Time.now.strftime("%Y-%m-%d %H:%M %z")}"
  end

  def add_comment_creator
    "# Creator: #{`git config user.email`}"
  end
end
