# HMVC

## Summary

- HMVC is the high-level model of MVC (MVC high-level structure)

- HMVC makes it easy to manage source code and develop projects

## Features

- Generate controller file
- Generate operations file
- Generate forms file
- Generate views file
- Add file creator and creation date

## Compatibility

  - Ruby `>= 2.6`

  - Rails `>= 6.0`

## Installation

Add this line to your application's Gemfile

```ruby
group :development do
  gem 'hmvc', git: 'git@github.com:TOMOSIA-VIETNAM/hmvc.git'
end
```

Then execute

    $ bundle install

And run

    $ rails g hmvc:install

```
create  config/initializers/hmvc.rb
create  app/operations/application_operator.rb
create  app/forms/application_form.rb
create  lib/error_handler/exception.rb
create  lib/error_handler/error_resource.rb
create  lib/error_handler/error_response.rb
```

## Usage

### Default generator

```
rails g hmvc controller_name
```

Example

```
rails g hmvc admin
```

```
create  app/controllers/admin_controller.rb
create  app/operations/admin/index_operator.rb
create  app/operations/admin/show_operator.rb
create  app/operations/admin/new_operator.rb
create  app/operations/admin/create_operator.rb
create  app/operations/admin/edit_operator.rb
create  app/operations/admin/update_operator.rb
create  app/operations/admin/destroy_operator.rb
create  app/forms/admin/new_form.rb
create  app/forms/admin/create_form.rb
create  app/forms/admin/edit_form.rb
create  app/forms/admin/update_form.rb
create  app/views/admin/index.html.erb
create  app/views/admin/show.html.erb
create  app/views/admin/new.html.erb
create  app/views/admin/edit.html.erb
```

### Options

#### 1. If you want to create with action other than default. You can use option `--action-controller` or `--ac`

```
rails g hmvc admin --ac index show list detail selection
```

#### 2. If you want to create with action other than default. You can use option `--action-form` or `--af`

```
rails g hmvc admin --ac index show list detail selection --af index show list
```

#### 3. If you want to create with parent controller other than default. You can use option `--parent-controller` or `--pc`

```
rails g hmvc admin --pc PersonController
```

#### 4. If you want to create with parent operation other than default. You can use option `--parent-operation` or `--po`

```
rails g hmvc admin --po PersonOperation
```

#### 5. If you want to create with parent operation other than default. You can use option `--parent-form` or `--pf`

```
rails g hmvc admin --pf PersonForm
```

#### 6. If you want to skip creating the forms file when generate. You can use option `--skip-form` or `--sf`

```
rails g hmvc admin --sf
```

Or change configuration `auto_create_form = false`

#### 7. If you want to skip creating the views file when generate. You can use option `--skip-view` or `--sv`

```
rails g hmvc admin --sv
```

Or change configuration `action_view = %w[]`

#### 8. Using error handling module. Recommended for API project

- config/application.rb

```ruby
config.autoload_paths << Rails.root.join('lib')
```

- application_controller.rb

```ruby
include ErrorHandler::ErrorResponse
```

## Configuration

If you want to change the default value when creating the file, please uncomment and update

- config/initializers/hmvc.rb

```ruby
# frozen_string_literal: true
# Created at: 2023-02-02 17:01 +0700
# Creator: thuc.phan@tomosia.com

Hmvc.configure do |config|
  # Save author name and timestamp to file. Default is true
  # config.file_traces = true

  # Automatically create the form files when you run the generate command. Default is true
  # config.auto_create_form = true

  # Method when creating the form files. Default is %w[new create edit update]
  # config.action_form = %w[new create edit update]

  # The form files's parent class. Default is ApplicationForm
  # config.parent_form = "ApplicationForm"

  # The operation files's parent class. Default is ApplicationOperation
  # config.parent_operation = "ApplicationOperation"

  # The controller files's parent class of controller. Default is ApplicationController
  # config.parent_controller = "ApplicationController"

  # Method when creating the controller files. Default is %w[index show new create edit update destroy]
  # config.action_controller = %w[index show new create edit update destroy]

  # Method when creating the view files. Default is %w[index show new edit]
  # config.action_view = %w[index show new edit]
end if Rails.env.development?
```

## Contributing

  - Thuc Phan T. thuc.phan@tomosia.com
  - Minh Tang Q.  minh.tang@tomosia.com

## License

The gem `hmvc` is copyright TOMOSIA VIET NAM CO., LTD

## About [TOMOSIA VIET NAM CO., LTD](https://www.tomosia.com/)

A company that creates new value together with customers and lights the light of happiness

【一緒に】【ハッピー】【ライトアップ】

お客様と共に新たな価値を生み出し幸せの明かりを灯す会社、トモシア

## Test and debug on development environment

- Add gem and run `bundle` (link to gem hmvc project)

```ruby
group :development do
  gem 'hmvc', path: '../../Projects/hmvc'
end
```

- Add `byebug` to the line you want to test

```ruby
def create_controller
  byebug
  template "controller.rb", File.join("app/controllers/#{class_path.join("/")}", "#{file_name}_controller.rb")
end
```

- Run command generator at Rails project terminal

```
rails g hmvc admin
```

```
   11:   class_option :skip_form,         type: :boolean, default: false,                                aliases: "--sf"
   12:   class_option :skip_view,         type: :boolean, default: false,                                aliases: "--sv"
   13:
   14:   def create_controller
   15:     byebug
=> 16:     template "controller.rb", File.join("app/controllers/#{class_path.join("/")}", "#{file_name}_controller.rb")
   17:   end
   18:
   19:   def create_operation
   20:     options[:action_controller].each do |action|
(byebug) options[:action_controller]
["index", "show", "new", "create", "edit", "update", "destroy"]
(byebug)
```
