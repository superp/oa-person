require "httparty"

module OaPerson
  class VkClient
    include ::HTTParty
        
    base_uri "http://api.vkontakte.ru"
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
    
    def default_options(method)
      {:v => API_VERSION, :api_id => @app_id, :format => 'json', :sid => @access_token, :sig => secret_md5(method)}
    end
    
    def get_profile(options)
      method = 'getProfiles'
      options = default_options(method).merge(:method => method, :uids => @user_id).merge(options)
      
      self.class.get('/api.php', options)
    end
    
    def wall_post(options = {})
      options = { :owner_id => @user_id, :access_token => @access_token }.merge(options)
      self.class.post("/method/wall.post", :body => options)
    end
    
    protected
      def secret_md5(method)
        "api_id=#{@app_id}method=#{method}v=#{API_VERSION}#{@app_secret}"
      end
  end
end
