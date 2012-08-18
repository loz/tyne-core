source "http://rubygems.org"

gemspec

gem "jquery-rails"

gem 'responders'
gem "active_model_serializers", :git => "git://github.com/josevalim/active_model_serializers.git"

# Tyne
#gem 'tyne_ui', :git => "git@github.com:tyne/tyne-ui.git"
gem 'tyne_ui', :path => '../tyne-ui'

# Webserver
gem 'thin'

group :production do
 gem 'pg'
end

# Testing
group :test, :development do
  #gem 'tyne_dev', :git => "git@github.com:tyne/tyne-dev.git"
  gem 'tyne_dev', :path => '../tyne-dev'
end
