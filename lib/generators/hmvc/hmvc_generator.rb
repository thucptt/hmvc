# frozen_string_literal: true

class HmvcGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  class_option :controller, type: :string, aliases: "-c"
  class_option :action, type: :string, aliases: "-a", default: "index show new edit create update destroy"

  def create_controller
    template "controller.rb", File.join("app/controllers/#{class_path.join("/")}", "#{file_name}_controller.rb")
  end

  private

  def add_comment_endpoint(action)
    url = "#{class_path.join("/")}/#{file_name}"
    case action
    when "index" then "# [GET] #{url}"
    when "show" then "# [GET] #{url}/1"
    when "new" then "# [GET] #{url}/new"
    when "edit" then "# [GET] #{url}/1/edit"
    when "create" then "# [POST] #{url}"
    when "update" then "# [PUT] #{url}/1"
    when "destroy" then "# [DELETE] #{url}/1"
    else "# [METHOD] #{url}/..."
    end
  end

  def add_comment_timestamp
    "# Created at: #{Time.current}"
  end

  def add_comment_creator
    "# Creator: #{`git config user.email`}"
  end
end
