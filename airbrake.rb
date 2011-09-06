require "httparty"

class Airbrake

  include HTTParty

  attr_reader :username, :auth_token, :project_id, :protocol

  def initialize(username, auth_token, project_id, protocol = "https")
    @username, @auth_token, @project_id, @protocol = username, auth_token, project_id, protocol
  end

  def fetch
    self.class.get("#{protocol}://#{username}.airbrakeapp.com/errors.xml", { :query => { :auth_token => auth_token, :project_id => project_id } })
  end

  def bugs
    response = fetch
    @protocol = "http" and response = fetch if response.blank?
    response["groups"]
  end

end
