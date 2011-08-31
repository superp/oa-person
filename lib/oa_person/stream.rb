module OaPerson
  class Stream
    attr_accessor :provider, :uid, :auth_hash, :options
    
    def initialize(provider, uid, auth_hash, options = {})
      @provider = provider.to_s
      @uid = uid.to_s
      @auth_hash = auth_hash
      @options = options
    end
    
    def access_token
      @auth_hash[:token]
    end
    
    def access_secret
      @auth_hash[:secret]
    end
    
    def client
      @client ||= connect
    end
    
    def image
      @auth_hash[:image]
    end
        
    def post(options = {})
      unless client.nil?
        publish(options)
      end
    end
    
    def publish(options = {})
      raise NotImplementedError, "Must be overwritten in subclasses"
    end
    
    protected
    
      def connect
        raise NotImplementedError, "Must be overwritten in subclasses"
      end
  end
end
