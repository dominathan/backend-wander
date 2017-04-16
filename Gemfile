source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.0'

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'dotenv-rails', require: 'dotenv/rails-now', group: [:development, :test]
gem 'jwt'
gem 'has_friendship'
gem 'searchkick'
gem 'rails_12factor'
gem 'aws-sdk', '~> 2'
gem 'paperclip'
gem 'geocoder'
gem 'sidekiq'
gem 'delayed_paperclip'

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
