require 'fb_graph'

module OaPerson
  class Social
    attr_accessor :provider, :name, :url
    
    cattr_accessor :collection
    @@collection = []
    
    def initialize(provider, options = {})
      @provider = provider.to_s
      @name = options[:name]
      @url = options[:url]
      
      @@collection << self
    end
    
    def image
      "icon_#{provider}.png"
    end
    
    def to_key
      [provider]
    end
    
    def self.model_name
      @_model_name ||= ActiveModel::Name.new(self)
    end
    
    def self.all
      @@collection
    end
  end
end
