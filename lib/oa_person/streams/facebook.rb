require "fb_graph"

module OaPerson
  module Streams
    class Facebook < Stream
    
      # Facebook feed
      # options are:
      #    :message => 'Updating via FbGraph',
      #    :picture => 'https://graph.facebook.com/matake/picture',
      #    :link => 'http://github.com/nov/fb_graph',
      #    :name => 'FbGraph',
      #    :description => 'A Ruby wrapper for Facebook Graph API'
      #    
      def publish(options = {})
        client.feed!(options)
      end
      
      # facebook image sizes => square | small | normal | large 
      def image_by_type(type)
        return nil if image.blank?
        image.gsub(/(type\=)square/, '\1' + type.to_s)
      end
      
      protected
      
        def connect
          begin
            ::FbGraph::User.me(access_token)
          rescue Exception => e
            Rails.logger.error(e)
            return nil
          end 
        end
    end
  end
end
