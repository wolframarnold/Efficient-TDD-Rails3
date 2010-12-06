source 'http://rubygems.org'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'nokogiri'

gem 'simple-rss'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails', "~> 2.1.0"
  gem 'cucumber-rails', "~> 0.3"
#  gem 'webrat', "~> 0.7"
  # Webrat from forked repo, to fix redirect bug: http://goo.gl/fCH5G
  # run bundle install to pull this version and install
  gem 'webrat', '>=0.7.2.beta.6', :git => 'git://github.com/orangewise/webrat'
end

group :test do
  gem 'factory_girl'
  gem 'fakeweb', '~> 1.3'
  gem 'launchy' # for opening error pages from webrat & capybara in a browser
end

group :development do
  gem 'hirb'
end
