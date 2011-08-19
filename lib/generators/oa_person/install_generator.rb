require 'rails/generators'
require 'rails/generators/migration'

module OaPerson
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    class_option :migrations, :type => :boolean, :default => true, :description => "Generate migrations files"

    desc "Generates post migration and model"

    def self.current_time
      @current_time ||= Time.now
      @current_time += 1.minute
    end

    def self.next_migration_number(dirname)
      current_time.strftime("%Y%m%d%H%M%S")
    end
    
    def create_models
      copy_file('person.rb', 'app/models/person.rb')
    end
    
    def create_migration
      if options.migrations
        migration_template "create_people.rb", File.join('db/migrate', "oa_person_create_people.rb")
      end
    end
  end
end
