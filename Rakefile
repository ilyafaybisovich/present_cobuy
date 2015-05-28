require File.expand_path('../config/application', __FILE__)
require 'rubocop/rake_task'

RuboCop::RakeTask.new :cop

task default: [:cop]
Rails.application.load_tasks

# for jasmine CI use rake jasmine:ci
