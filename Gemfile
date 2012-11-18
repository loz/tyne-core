source "http://rubygems.org"

gemspec

gem "jquery-rails"
gem 'execjs'
gem 'therubyracer'
gem 'sass-rails'
gem 'compass-rails'

gem 'responders', :git => 'https://github.com/plataformatec/responders.git'
gem "active_model_serializers", :git => "https://github.com/rails-api/active_model_serializers.git"
gem "simple_form"
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

# Tyne
gem 'tyne_auth', :git => 'https://github.com/tyne/tyne-auth.git', :branch => 'master'

gem 'modernizr-rails'
gem "mousetrap-rails"
gem "redcarpet"
gem "md_emoji"

# Webserver
gem 'thin'

group :production do
 gem 'pg'
end

# Testing
group :test, :development do
  gem 'tyne_dev', :git => 'https://github.com/tyne/tyne-dev.git', :branch => 'master'
end
