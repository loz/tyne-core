source "http://rubygems.org"

gemspec

gem "jquery-rails"

gem 'responders'
gem "active_model_serializers", :git => "git://github.com/josevalim/active_model_serializers.git"

# Tyne
gem 'tyne-ui', :git => "git@github.com:tyne/tyne-ui.git"

# Webserver
gem 'thin'

group :production do
 gem 'pg'
end


# Testing
group :test, :development do
  gem 'tyne-dev', :git => "git@github.com:tyne/tyne-dev.git"
end
