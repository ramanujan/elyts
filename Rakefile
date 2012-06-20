#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Elyts::Application.load_tasks


# relativize
namespace :assets do
  desc "Make all embedded assets in stylesheets relative paths"
  task :relativize => :environment do
    Dir[Rails.root.join("public/assets") + "*.css"].each do |asset|
      contents = File.read(asset)
      File.open(asset, "w") do |file|
        file.puts contents.gsub("url(/assets/", "url(")
      end
    end
  end
end
