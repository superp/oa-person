# encoding: utf-8
module OaPerson
  module Models
    module Base
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
      end
      
      module ClassMethods
        def self.extended(base)
          base.class_eval do
            validates_presence_of :uid, :provider, :auth_hash
            validates_uniqueness_of :uid, :scope => :provider

            serialize :auth_hash, Hash
          end
        end
        
        def find_from_hash(hash)
          return if hash.nil? || hash.keys.empty?
          find_by_provider_and_uid(hash['provider'], hash['uid'])
        end

        def create_from_hash(hash)
          create do |person|
            person.uid = hash['uid']
            person.provider = hash['provider']
            person.auth_hash = hash
            person.name = person.user_attributes[:name]
            person.email = person.user_attributes[:email]
            person.login = person.user_attributes[:nickname]
            person.link = person.user_attributes[:link]
            person.photo_url = person.user_attributes[:photo_url]
          end
        end
      end
      
      module InstanceMethods
        def nickname
          @nickname = self.login
          @nickname ||= extract_login(user_attributes[:email])
        end
        
        def user_attributes
          @user_attributes ||= extract_user_attributes(auth_hash)
        end
      
        protected
          
          def extract_user_attributes(hash)
            user_credentials = hash['credentials'] || {}
            user_info = hash['user_info'] || {}
            user_hash = hash['extra'] ? (hash['extra']['user_hash'] || {}) : {}
            
            { 
              :token => user_credentials['token'],
              :secret => user_credentials['secret'],
              :name => user_info['name'], 
              :email => (user_info['email'] || user_hash['email']),
              :nickname => user_info['nickname'],
              :last_name => user_info['last_name'],
              :first_name => user_info['first_name'],
              :link => (user_info['link'] || user_hash['link']),
              :photo_url => (user_info['image'] || user_hash['image']),
              :locale => (user_info['locale'] || user_hash['locale']),
              :description => (user_info['description'] || user_hash['description'])
            }
          end
          
          def extract_login(email)
            unless email.nil?
              email.split('@').first.gsub(/[^A-Za-z0-9-]+/, '-').gsub(/-+/, '-')
            end
          end
      end
    end
  end
end
