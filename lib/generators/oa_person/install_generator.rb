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
    
    def copy_controllers
      copy_file('sessions_controller.rb', 'app/controllers/sessions_controller.rb')
    end
    
    def copy_config
      copy_file('config.rb', 'config/initializers/omniauth.rb')
    end
    
    def add_routes
      log :add_routes, "sessions"
      route "match '/auth/:provider/callback', :to => 'sessions#create'"
      route "match '/auth/failure', :to => 'sessions#failure'"
      route "match '/signout' => 'sessions#destroy', :as => :signout"
    end
    
    def add_helpers
      code = "include OaPerson::Helpers"
      sentinel = /protect_from_forgery/
       
      in_root do
        inject_into_file 'app/controllers/application_controller.rb', "\n  #{code}\n", { :after => sentinel, :verbose => false }
      end
    end

  end
end
