source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'mysql2'

gem 'thin'

gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.1.1'
  # gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use debugger
# gem 'debugger'

gem 'rspec-rails', :group => [:development, :test]
gem 'spin', :group => [:development, :test]

#in place editing
gem 'best_in_place' #, :git => 'git://github.com/bernat/best_in_place.git'

# Nabaztag
gem "nabaztag_hack_kit" #, :path => "../NabaztagHackKit"

group :test do
  #fixtures
  gem 'faker'
  gem 'factory_girl_rails'

  gem 'capybara'
  # gem 'watchr'
  # gem 'simplecov'

  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end

group :client do
  gem 'json'
  gem 'serialport'
end
