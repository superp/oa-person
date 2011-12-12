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
          return if hash.nil? || hash['provider'].blank? || hash['uid'].blank?
          where([ "provider = ? AND uid = ?", hash['provider'], hash['uid'] ]).first
        end

        def create_from_hash(hash)
          create do |person|
            person.uid = hash['uid']
            person.provider = hash['provider']
            person.auth_hash = hash
            
            person.name = person.user_attributes[:name]
            person.email = person.user_attributes[:email]
            person.login = person.user_attributes[:nickname]
            person.link = person.user_attributes[:url]
            person.photo_url = person.user_attributes[:image]
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
        
        def stream
          @stream ||= stream_klass.new(provider, uid, user_attributes) unless stream_klass.nil?
        end
        
        def stream_klass
          case provider.to_sym
            when :facebook then OaPerson::Streams::Facebook
            when :twitter then OaPerson::Streams::Twitter
            # Not work by OpenAuth
            when :vkontakte then OaPerson::Streams::Vkontakte
            else nil
          end
        end
      
        protected
          
          def extract_user_attributes(hash)
            user_credentials = hash['credentials'] || {}
            
            user_info = hash['info'] || {}
            user_hash = hash['extra'] || {}
            
            { 
              :token => user_credentials['token'],
              :secret => user_credentials['secret'],
              :name => user_info['name'], 
              :email => (user_info['email'] || user_hash['email']),
              :nickname => user_info['nickname'],
              :last_name => user_info['last_name'],
              :first_name => user_info['first_name'],
              :image => (user_info['image'] || user_hash['image']),
              :locale => (user_info['locale'] || user_hash['locale']),
              :description => (user_info['description'] || user_hash['description']),
              :location => user_info['location'],
              :url => user_info['urls'][provider.titleize]
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
