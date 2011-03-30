require "httparty"

class Hoptoad

  include HTTParty

  attr_reader :username, :auth_token, :project_id

  def initialize(username, auth_token, project_id)
    @username, @auth_token, @project_id = username, auth_token, project_id
  end

  def bugs
    response = self.class.get("http://#{username}.hoptoadapp.com/errors.xml", { :query => { :auth_token => auth_token, :project_id => project_id } })
    response["groups"]
  end

end