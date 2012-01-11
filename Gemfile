source 'http://rubygems.org'

gem 'rails', '3.2.0.rc2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.1.1'
  # gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails', :group => [:development, :test]
gem 'spin', :group => [:development, :test]

#in place editing
#gem 'best_in_place'
gem "best_in_place", :git => "git://github.com/bernat/best_in_place.git"

group :test do
  #fixtures
  gem 'faker'
  gem 'factory_girl_rails'

  gem 'capybara'
  # gem 'watchr'
  # gem 'simplecov'
end

group :client do
  gem 'json'
  gem 'serialport'
end
