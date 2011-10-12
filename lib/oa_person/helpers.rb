# encoding: utf-8
module OaPerson
  module Helpers
    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend,  ClassMethods
    end
    
    module ClassMethods
      def self.extended(base)
        base.class_eval do
          helper_method :current_person, :person_signed_in?
        end
      end
    end
    
    module InstanceMethods    
      protected
        
        def person_signed_in?
          !!current_person
        end
        
        def current_person=(new_person)
          session[:person_id] = new_person ? new_person.id : nil
          @current_person = new_person || false
        end
        
        def current_person
           @current_person ||= person_login_from_session unless @current_person == false
        end
        
        def person_login_from_session
          self.current_person = Person.find_by_id(session[:person_id]) if session[:person_id]
        end
    end
  end
end
