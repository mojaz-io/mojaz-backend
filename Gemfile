source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bootsnap", ">= 1.4.2", require: false # Boot large ruby/rails apps faster
gem "jbuilder", "~> 2.9" # # Create JSON structures via a Builder-style DSL
gem "jquery-rails", "~> 4.3" #  A gem to automate using jQuery with Rails
gem "kaminari", "~> 1.1" # A Scope & Engine based, clean, powerful, customizable and sophisticated paginator
gem "nokogiri", "~> 1.10" # HTML, XML, SAX, and Reader parser
gem "pg", ">= 0.18', '< 2.0" # Pg is the Ruby interface to the PostgreSQL RDBMS
gem "puma", "~> 3.12" # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server
gem "rack-timeout", "~> 0.5" # Rack middleware which aborts requests that have been running for longer than a specified timeout
gem "rails", "~> 6.0.0" # Ruby on Rails
gem "sass-rails", "~> 5.1" # Sass adapter for the Rails asset pipeline
gem "sprockets", "~> 3.7" # Sprockets is a Rack-based asset packaging system
# gem "timber", "~> 3.0" # Great Ruby logging made easy
# gem "timber-rails", "~> 1.0" #  Timber integration for Rails
gem "turbolinks", "~> 5" # Turbolinks makes navigating your web application faster.
gem "validate_url", "~> 1.0" # Library for validating urls in Rails
gem "webpacker", "~> 4.0" # Use webpack to manage app-like JavaScript modules in Rails

group :development do
  gem "better_errors", "~> 2.5" # Provides a better error page for Rails and other Rack apps
  gem "binding_of_caller", "~> 0.8" # Retrieve the binding of a method's caller
  gem "brakeman", "~> 4.6", require: false # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis
  gem "derailed_benchmarks", "~> 1.3", require: false # A series of things you can use to benchmark a Rails or Ruby app
  gem "erb_lint", "~> 0.0", require: false # ERB Linter tool
  gem "fix-db-schema-conflicts", "~> 3.0" # Ensures consistent output of db/schema.rb despite local differences in the database
  # switch foreman to stable release when thor dependency is updated to 0.20+
  gem "foreman", github: "thepracticaldev/foreman", ref: "b64e401", require: false # Process manager for applications with multiple components
  gem "guard", "~> 2.15", require: false # Guard is a command line tool to easily handle events on file system modifications
  gem "guard-livereload", "~> 2.5", require: false # Guard::LiveReload automatically reloads your browser when 'view' files are modified
  gem "guard-rspec", "~> 4.7", require: false # Guard::RSpec automatically run your specs
  gem "memory_profiler", "~> 0.9", require: false # Memory profiling routines for Ruby 2.3+
  gem "pry", "~> 0.12" # An IRB alternative and runtime developer console
  gem "pry-rails", "~> 0.3" # Use Pry as your rails console
  gem "web-console", "~> 3.7" # Rails Console on the Browser
  gem "yard", "~> 0.9.20" # YARD is a documentation generation tool for the Ruby programming language
  gem "yard-activerecord", "~> 0.0.16" # YARD extension that handles and interprets methods used when developing applications with ActiveRecord
  gem "yard-activesupport-concern", "~> 0.0.1" # YARD extension that brings support for modules making use of ActiveSupport::Concern
end

group :development, :test do
  gem "awesome_print", "~> 1.8" # Great Ruby dubugging companion: pretty print Ruby objects to visualize their structure
  gem "bullet", "~> 6.0" # help to kill N+1 queries and unused eager loading
  gem "capybara", "~> 3.28" # Capybara is an integration testing tool for rack based web applications
  gem "faker", "~> 2.1" # A library for generating fake data such as names, addresses, and phone numbers
  gem "parallel_tests", "~> 2.29" # Run Test::Unit / RSpec / Cucumber / Spinach in parallel
  gem "pry-byebug", "~> 3.7" # Combine 'pry' with 'byebug'. Adds 'step', 'next', 'finish', 'continue' and 'break' commands to control execution
  gem "rspec-rails", "~> 3.8" # rspec-rails is a testing framework for Rails 3+
  gem "rubocop", "~> 0.74", require: false # Automatic Ruby code style checking tool
  gem "rubocop-performance", "~> 1.4", require: false # A collection of RuboCop cops to check for performance optimizations in Ruby code
  gem "rubocop-rails", "~> 2.2", require: false # Automatic Rails code style checking tool
  gem "rubocop-rspec", "~> 1.35", require: false # Code style checking for RSpec files
  gem "spring", "~> 2.1" # Preloads your application so things like console, rake and tests run faster
  gem "spring-commands-rspec", "~> 1.0" # rspec command for spring
end

group :test do
  gem "approvals", "~> 0.0" # A library to make it easier to do golden-master style testing in Ruby
  gem "factory_bot_rails", "~> 4.11" # factory_bot is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies
  gem "launchy", "~> 2.4" # Launchy is helper class for launching cross-platform applications in a fire and forget manner.
  gem "pundit-matchers", "~> 1.6" # A set of RSpec matchers for testing Pundit authorisation policies
  gem "rspec-retry", "~> 0.6" # retry intermittently failing rspec examples
  gem "ruby-prof", "~> 1.0", require: false # ruby-prof is a fast code profiler for Ruby
  gem "shoulda-matchers", "4.1.2", require: false # Simple one-liner tests for common Rails functionality
  gem "simplecov", "~> 0.17", require: false # Code coverage with a powerful configuration library and automatic merging of coverage across test suites
  gem "stackprof", "~> 0.2", require: false, platforms: :ruby # stackprof is a fast sampling profiler for ruby code, with cpu, wallclock and object allocation samplers
  gem "test-prof", "~> 0.9" # Ruby Tests Profiling Toolbox
  gem "timecop", "~> 0.9" # A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code
  gem "vcr", "~> 5.0" # Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests
  gem "webdrivers", "~> 4.1" # Run Selenium tests more easily with install and updates for all supported webdrivers
  gem "webmock", "~> 3.6" # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests
  gem "zonebie", "~> 0.6.1" # Runs your tests in a random timezone
end

group :doc do
  gem "sdoc", "~> 1.0" # rdoc generator html with javascript search index
end
