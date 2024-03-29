source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
gem 'factory_bot_rails'

# Use Puma as the app server
gem 'puma', '~> 4.3.6'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
gem 'stripe-ruby-mock', '~> 3.0.1', :require => 'stripe_mock'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'turbolinks_render'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'pundit'
gem 'money-rails'
gem 'stripe'
gem 'stripe_event'
gem 'rails-i18n'
gem 'kaminari-i18n'
gem 'image_processing', '~> 1.2'
gem 'mail_form'
gem 'friendly_id', '~> 5.4.0'
# gem 'social-share-button'
gem 'cloudinary', '~> 1.12.0'
gem 'will_paginate', '~> 3.1.0'
gem 'pg_search', '~> 2.3.0'
gem 'httparty'
gem "active_storage_validations"
gem 'sitemap_generator'
gem 'remote_syslog_logger'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise'
gem 'devise-i18n'

gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'simple_form'

gem 'invisible_captcha'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'shoulda-matchers'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  gem 'bullet'
  gem 'rack-mini-profiler'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
