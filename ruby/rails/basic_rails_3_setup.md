Create new rails applicaiton omitting prototype.js and Test

    $ rails new geo_cms -JT
 
Create RVM config

    $ rvm --create --rvmrc <RUBY_VERSION>@<GEMSET_NAME>

In Gemfile

```ruby

# These are some boilerplate gems notionally required for any Rails 3 project. 

gem 'rails'

gem 'capistrano'
gem 'rvm-capistrano'
gem 'capistrano-ext'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # libv8-dev was dependency problem with Ubuntu, possibly a version conflict. 
  gem 'libv8'
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# jquery-rails
gem "jquery-rails"

group :development do
  gem "bundler"
  gem "jeweler"
  gem 'simplecov'
  gem 'rdoc'
  gem 'rspec'
  gem 'rspec-rails'
end
```
 
Install gems

    $ bundle
 
In config/application.rb, add some generator config so new models and scaffolds use erb and RSpec

```ruby
config.generators do |g|
  g.template_engine :erb
  g.test_framework :rspec
end
```
 
Add jquery to the app/assets/javascripts/application.js # manifest file
```ruby
	//= require jquery
	//= require jquery_ujs
```

Install RSpec (adds spec_helper and others)

    $ rails g rspec:install