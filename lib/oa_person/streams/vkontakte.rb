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
        client.wall_post(options)
      end
      
      def image_by_type(type)
        return nil if image.blank?
        image
      end
      
      def profile_image_source
        client.getProfiles(:uids => uid, :fields => 'photo_big,photo,photo_medium,photo_rec').inspect
      end
      
      protected
      
        def connect
          begin
            #OaPerson::VkClient.new(uid, access_token, 2457517, 'WUJhMeMDy2opiqSqJ4K3')
            app = ::VK::Serverside.new(:app_id => 2457517, :app_secret => 'WUJhMeMDy2opiqSqJ4K3')
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
