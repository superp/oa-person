require "httparty"
require 'digest/md5'

module OaPerson
  class VkClient
    include ::HTTParty
        
    base_uri "https://api.vkontakte.ru"
    format :json
    
    API_VERSION = '3.0'
    
    attr_accessor :user_id, :access_token, :app_id, :app_secret
    
    #http://api.vkontakte.ru/api.php?v=3.0&api_id=2457517&method=getProfiles&format=json&rnd=343&uids=100172&fields=photo%2Csex&sid=10180116c4fd93480439bca47d636d6dd75fac30b851d4312e82ec3523&sig=5be698cf7fa09d30f58b941a4aea0e9b
    
    
    def initialize(user_id, access_token, app_id, app_secret)
      @user_id = user_id
      @access_token = access_token
      @app_id = app_id
      @app_secret = app_secret
    end
    
    def default_options
      {:v => API_VERSION, :api_id => @app_id, :format => 'json'}#, :sid => @access_token}
    end
    
    def get_profile(options = {})
      options = default_options.merge(:method => 'getProfiles', :uids => @user_id).merge(options)
      options.merge!(:sig => secret_md5(options))
      
      self.class.get('/api.php', options).body
    end
    
    def wall_post(options = {})
      options = { :owner_id => @user_id, :access_token => @access_token }.merge(options)
      self.class.post("/method/wall.post", :body => options)
    end
    
    protected
      def secret_md5(options)
        params = ''
        
        options.keys.sort{|x,y| x.to_s <=> y.to_s}.each do |key|
          params += "#{key}=#{options[key]}"
        end
        
        Digest::MD5.hexdigest(params + @app_secret)
      end
  end
end
