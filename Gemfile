source "http://rubygems.org"

gemspec

gem "jquery-rails"
gem 'execjs'
gem 'therubyracer'

gem 'responders', :git => 'git://github.com/plataformatec/responders.git'
gem "active_model_serializers", :git => "git://github.com/josevalim/active_model_serializers.git"
gem "simple_form"

# Tyne
gem 'tyne_ui', :path => '../tyne-ui'
gem 'modernizr-rails'
gem 'jquery-ui-themes'


# Webserver
gem 'thin'

group :production do
 gem 'pg'
end

# Testing
group :test, :development do
  gem 'tyne_dev', :path => '../tyne-dev'
end
