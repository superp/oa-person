# Providers   
ChangeMePlease::Application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'id', 'secret', { :scope => 'publish_stream,offline_access,email,user_photos', :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :vkontakte, 'id', 'secret', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end

if Object.const_defined?("OaPerson")
  OaPerson.setup do |config|
    config.vkontakte_app_id = "id"
    config.vkontakte_app_secret = "secret"
  end
end
