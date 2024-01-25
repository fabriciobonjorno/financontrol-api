source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'rails-i18n', '~> 7.0.0'
gem 'tzinfo-data', platforms: %i[windows jruby]
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
gem 'jwt_sessions'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'dry-transaction'
gem 'dry-validation'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"
gem 'kaminari'
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  # Hirb.enable console command
  gem 'hirb'
  # Autoload dotenv in Rails.
  gem 'dotenv-rails'
  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3.3'
  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 6.0'
  # Set of matchers and helpers to allow you test your APIs responses like a pro.
  gem 'rspec-json_expectations', '~> 2.2'
  # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.
  gem 'webmock', '~> 3.18'
  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'
  # Simple one-liner tests for common Rails functionality
  gem 'shoulda-matchers', '~> 5.3'
  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses..
  gem 'faker', '~> 3.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
