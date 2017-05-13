source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.0'

gem 'rails', '5.0.1'
gem 'pg', '~> 0.19.0'
gem 'puma', '~> 3.7.0'
gem 'dotenv-rails', require: 'dotenv/rails-now', group: [:development, :test]
gem 'jwt', '1.5.6'
gem 'has_friendship', '1.0.2'
gem 'rails_12factor', '0.0.3'
gem 'aws-sdk', '~> 2.8.14'
gem 'paperclip', '5.1.0'
gem 'geocoder', '1.4.3'
gem 'sidekiq', '4.2.10'
gem 'delayed_paperclip', '3.0.1'
gem 'pg_search', '2.0.1'
gem 'newrelic_rpm',  '~> 3.15.2.317'

gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
