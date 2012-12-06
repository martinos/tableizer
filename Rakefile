#!/usr/bin/env rake
require 'bundler'
Bundler.require(:default, :development)
require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
  # To avoid requirement of File.expand_path(File.dirname(__FILE__) + 'test_helper') from test files
  t.libs << 'test'
end


task :default => [:test] 

