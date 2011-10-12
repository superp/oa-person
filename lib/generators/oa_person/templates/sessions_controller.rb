class SessionsController < ActionController::Metal

  def create
    auth_hash = request.env['omniauth.auth']
    auth_item = Person.find_from_hash(auth_hash)
    auth_item ||= Person.create_from_hash(auth_hash)
    
    #current_person = auth_item
    session[:person_id] = auth_item ? auth_item.id : nil
    
    redirect_to "/contest/collages/new"
  end
  
  def destroy
    session[:person_id] = nil
    redirect_to "/"
  end
  
  def failure
    redirect_to "/contest"
  end
  
  protected
  
    def warden
      request.env['warden']
    end
  
    def redirect_to(location, options = {}) #:doc:
      raise ::ActionControllerError.new("Cannot redirect to nil!") if location.nil?
      raise ::AbstractController::DoubleRenderError if response_body

      self.status        = (options.delete(:status) || 302).to_i
      self.location      = location
      self.response_body = "<html><body>You are being <a href=\"#{::ERB::Util.h(location)}\">redirected</a>.</body></html>"
    end
end
