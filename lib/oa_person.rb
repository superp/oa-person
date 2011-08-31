# encoding: utf-8
#require 'omniauth'

module OaPerson
  module Models
    autoload :Base, 'oa_person/models/base'
  end
  
  autoload :Social, 'oa_person/social'
  autoload :Stream, 'oa_person/stream'
  autoload :VkClient, 'oa_person/vk_client'
  
  module Streams
    autoload :Facebook, 'oa_person/streams/facebook'
    autoload :Twitter, 'oa_person/streams/twitter'
    autoload :Vkontakte, 'oa_person/streams/vkontakte'
  end
end

require 'oa_person/version'
