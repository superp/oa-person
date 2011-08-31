require "twitter"

module OaPerson
  module Streams
    class Twitter < Stream
    
      # Twitter feed
      # options are:
      #    :message => 'Updating via twitter',
      #    
      def publish(options = {})
        client.update(options[:message])
      end
      
      protected
      
        def connect
          begin
            ::Twitter::Client.new(twitter_oauth)
          rescue Exception => e
            Rails.logger.error(e)
            return nil
          end 
        end
        
        def twitter_oauth
          #@twitter_oauth ||= ::Twitter::OAuth.new('x5JSjGQpkevMJzyJoDqFLA', '4AzlBPed3aZugdIneChSx2q0bQ9i2D9S9RMCoktb0Q')
          @twitter_oauth ||= {
            :consumer_key => 'x5JSjGQpkevMJzyJoDqFLA',
            :consumer_secret => '4AzlBPed3aZugdIneChSx2q0bQ9i2D9S9RMCoktb0Q',
            :oauth_token => access_token,
            :oauth_token_secret => access_secret
          }
        end
    end
  end
end
