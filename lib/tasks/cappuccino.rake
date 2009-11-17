# Load config/cappuccino.yml. If it doesn't exist, copy config/cappuccino.yml.sample to it
require 'yaml'
begin
  config = YAML.load_file(File.join('config', 'cappuccino.yml'))
rescue
  sh "cp config/cappuccino.yml.sample config/cappuccino.yml"
  puts "You need to edit config/cappuccino.yml to match your system."
  exit
end

namespace :cappuccino do
  desc "Downloads the latest from Github and rebuilds on the local system"
  task :update => [:update_source, :build, "cappuccino:doc:build"]
  
  desc "Pulls the latest from Github to #{config['cappuccino_source']}"
  task :update_source do
    sh "cd #{config['cappuccino_source']} && git pull"
  end
  
  desc "Rebuilds Cappuccino from #{config['cappuccino_source']} to #{ENV['CAPP_BUILD']}"
  task :build do
    sh "cd #{config['cappuccino_source']} && rake clobber-all install"
  end
  
  desc "Run the capp command with options to just symlink the Frameworks in."
  task :symlink do
    sh "capp gen public/map_editor/ -l -f"
  end
  
  namespace :doc do
    desc "Build the docs for the currently built version of Cappuccino"
    task :build do
      sh "cd #{config['cappuccino_source']} && rake docs"
    end
    
    desc "Symlink the docs built in #{ENV['CAPP_BUILD']}/Documentation/html/ to doc/cappuccino/"
    task :symlink do
      sh "ln -s #{ENV['CAPP_BUILD']}/Documentation/html/ doc/cappuccino"
    end
  end
end