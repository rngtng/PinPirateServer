source 'http://rubygems.org'

gem 'rails', '3.2.0'
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

# Deploy with Capistrano
gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails', :group => [:development, :test]
gem 'spin', :group => [:development, :test]

#in place editing
gem 'best_in_place'

gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'

# Nabaztag
gem "nabaztag_hack_kit" #, :path => "../NabaztagHackKit"

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
