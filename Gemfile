# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.7"
gem "mysql2", "0.2.10"
gem "unicorn", "3.7.0"
gem "will_paginate", "~> 3.0.pre2"
gem 'farsifu'
gem 'rubyzip'

gem 'i18n-active_record',
      :git => 'git://github.com/svenfuchs/i18n-active_record.git',
      :require => 'i18n/active_record'

# jquery rails installer
gem 'jquery-rails'

#gem 'jalalidate'
gem 'calendar'

gem 'pdfkit'
gem 'wkhtmltopdf-binary', '0.9.5.3'

# Amazon email service
gem 'aws-ses', '0.4.3', :require => 'aws/ses'

# TODO: Are these used?
gem 'beanstalk-client'
gem 'stalker'

group :development do
  gem 'capistrano', '2.6.0'
end

group :test do
  gem 'database_cleaner'
  gem 'cucumber-rails', ">= 0.3.2"
  gem 'cucumber'
  gem "rspec", ">= 2.0.0"
  gem "rspec-rails", ">= 2.0.0"
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem "webrat", ">= 0.7.2"
end

