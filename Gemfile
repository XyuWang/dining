source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'


gem 'devise'
gem 'cancan'
gem 'state_machine'
gem 'role_model'
gem "paperclip", "~> 3.0"
gem 'rmagick'
gem 'kaminari'
gem 'rails-i18n'

group :production, :deploy do
  gem 'passenger'
  gem 'mysql2'
end

group :development, :test do
  gem 'factory_girl',       '2.0.2'      # 2.0.3 breaks loading factories with a Duplication Error
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'email_spec', require: false
  gem 'shoulda-matchers'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'debugger'
  gem 'sqlite3'
end

group :development do
end

group :test do
  gem "simplecov"
  gem "email_spec", :require => false
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'


# Deploy with Capistrano
# gem 'capistrano'
