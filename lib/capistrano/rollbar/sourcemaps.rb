# Core tasks
load File.expand_path('../../tasks/sourcemaps.rake', __FILE__)

namespace :deploy do
  after :set_current_revision, 'rollbar:sourcemaps:upload'
end

namespace :load do
  task :defaults do
    load "capistrano/rollbar/sourcemaps/defaults.rb"
  end
end
