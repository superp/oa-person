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
      
      def publish_by_user(user_id, options = {})
        begin
          user = FbGraph::User.new(user_id, :access_token => access_token)
          user.feed!(options) 
        rescue Exception => e
          Rails.logger.error(e)
          return nil
        end
      end
      
      # facebook image sizes => square | small | normal | large 
      def image_by_type(type)
        return nil if image.blank?
        image.gsub(/(type\=)square/, '\1' + type.to_s)
      end
      
      def is_fun(group_id, user_id=uid)
        # "https://api.facebook.com/method/pages.isFan?format=json&access_token=" . USER_TOKEN . "&page_id=" . FB_FANPAGE_ID"
        FbGraph::Query.new("SELECT uid FROM page_fan WHERE uid=#{user_id} AND page_id=#{group_id}").fetch(access_token)
      end
      
      def friends
        client.friends
      end
      
      def profile_photos(user_id=uid)
        #user = user_id == uid ? client : FbGraph::User.fetch(user_id, :access_token => access_token)
        #album = user.albums.detect{|a| a.type == 'profile'}
        #album.photos
        FbGraph::Query.new("SELECT pid, src_big, src FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=#{user_id} AND type='profile')").fetch(access_token)
      end
      
      def profile_image_source
        a = client.albums.detect{|a| a.type == 'profile'}
        return nil if a.blank?
        
        image = ::FbGraph::Photo.fetch(a.cover_photo.identifier, :access_token => access_token)
        image.try(:source)
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
