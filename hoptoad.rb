require "httparty"

class Hoptoad

  include HTTParty

  attr_reader :username, :auth_token, :project_id, :protocol

  def initialize(username, auth_token, project_id, protocol = 'http')
    @username, @auth_token, @project_id, @protocol = username, auth_token, project_id, protocol
  end

  def fetch
    self.class.get("#{protocol}://#{username}.hoptoadapp.com/errors.xml", { :query => { :auth_token => auth_token, :project_id => project_id } })
  end
  
  def bugs
    response = fetch
    @protocol = 'https' and response = fetch if response.blank?
    response["groups"]
  end

end