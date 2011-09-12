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
        options = {:wall_id => uid}.merge(options)
        client.wall.savePost(options)
      end
      
      def image_by_type(type)
        return nil if image.blank?
        image
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
            
            #TODO get this values from omniauth config
            app = ::VK::Serverside.new(:app_id => 'your_id', :app_secret => 'your_secret')
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
