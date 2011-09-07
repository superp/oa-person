require "oa_person/vk_client"

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
        return nil if image.blank?
        image
      end
      
      protected
      
        def connect
          begin
            OaPerson::VkClient.new(uid, access_token)
          rescue Exception => e
            Rails.logger.error(e)
            return nil
          end 
        end
    end
  end
end
