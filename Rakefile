require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end

Cucumber::Rake::Task.new(:wip) do |t|
  t.cucumber_opts = "features --format pretty -x --tags @wip"
  t.fork = false
end

RSpec::Core::RakeTask.new(:spec)
