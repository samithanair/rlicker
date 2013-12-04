# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "rlicker"
  gem.homepage = "http://github.com/ben-biddington/rlicker"
  gem.license = "MIT"
  gem.summary = %Q{}
  gem.description = %Q{}
  gem.email = "ben.biddington@gmail.com"
  gem.authors = ["Ben Biddington"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'

task :default => :ci

desc "Run all tests"
RSpec::Core::RakeTask.new

desc "Run just the tests suitable for CI"
RSpec::Core::RakeTask.new do |t|
  t.name = :ci
  t.pattern = "spec/integration/capybara_webkit_spec.rb"
end
