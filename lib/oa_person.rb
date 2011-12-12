# encoding: utf-8
require 'omniauth'
require 'omniauth-vkontakte'
require 'omniauth-facebook'

module OaPerson
  module Models
    autoload :Base, 'oa_person/models/base'
  end
  
  autoload :Config, 'oa_person/config'
  autoload :Social, 'oa_person/social'
  autoload :Stream, 'oa_person/stream'
  #autoload :VkClient, 'oa_person/vk_client'
  autoload :Helpers, 'oa_person/helpers'
  
  module Streams
    autoload :Facebook, 'oa_person/streams/facebook'
    autoload :Twitter, 'oa_person/streams/twitter'
    autoload :Vkontakte, 'oa_person/streams/vkontakte'
  end
  
  mattr_accessor :vkontakte_app_id
  @@vkontakte_app_id = 'app_id'
  
  mattr_accessor :vkontakte_app_secret
  @@vkontakte_app_secret = 'app_secret'
  
  def self.setup
    yield self
  end
end

require 'oa_person/version'
