require "httparty"

module OaPerson
  class VkClient
    include ::HTTParty
        
    base_uri "https://api.vkontakte.ru"
    format :json
    
    attr_accessor :user_id, :access_token
    
    def initialize(user_id, access_token)
      @user_id = user_id
      @access_token = access_token
    end
    
    def wall_post(options = {})
      options = { :owner_id => @user_id, :access_token => @access_token }.merge(options)
      self.class.post("/method/wall.post", :body => options)
    end
  end
end
