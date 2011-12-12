#require "oa_person/vk_client"
require 'vk-ruby'

module OaPerson
  module Streams
    class Vkontakte < Stream
    
      # Vkontakte feed
      # options are:
      #    :owner_id => 'user_id',
      #    :message => 'Updating via twitter',
      #    :attachment => 'link'
      #    
      def publish(options = {})
        options = {:owner_id => options[:user_id], :message => options[:message], :attachment => options[:link]}
        client.wall.post(options)
      end
      
      def friends
        options = {:uid => uid, :fields => "uid,first_name,last_name", :timestamp => Time.now.getutc.to_i, :random => Time.now.to_i}
        client.friends.get(options)
      end
      
      # Vkontakte post photo
      # 1) photos.getUploadServer 
      # 2) POST-запрос (поля file1-file5)
      # 3) photos.save
      #    
      def post_photo(options = {})
        
      end
      
      def image_by_type(type)
        return nil if image.blank?
        image
      end
      
      def profile_photos(user_id=uid)
        options = {:owner_id => user_id, :count => 30}
        photos = client.photos.getAll(options)
        photos.shift
        photos
      end
      
      def profile_image_source(options)
        #client.getProfiles(:uids => uid, :fields => 'photo_big,photo,photo_medium,photo_rec').inspect
        options = {:uid => uid}.merge(options)
        client.photos.get(options)
      end
      
      protected
      
        def connect
          begin
            #OaPerson::VkClient.new(uid, access_token, your_id, 'your_secret')
            app = ::VK::Standalone.new(:app_id => OaPerson.vkontakte_app_id, :app_secret => OaPerson.vkontakte_app_secret)
            app.access_token = access_token
            app
          rescue Exception => e
            Rails.logger.error(e)
            return nil
          end 
        end
    end
  end
end
