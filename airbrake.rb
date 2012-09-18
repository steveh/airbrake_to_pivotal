require "httparty"

class Airbrake

  include HTTParty

  attr_reader :username, :auth_token, :project_ids, :protocol

  def initialize(username, auth_token, project_ids = [], protocol = "https")
    @username, @auth_token, @project_ids, @protocol = username, auth_token, project_ids, protocol
  end

  def fetch
    project_ids.collect do |project_id|
      self.class.get(
        "#{protocol}://#{username}.airbrake.io/errors.xml",
        {
          :query => {
            :auth_token => auth_token,
            :project_id => project_id
          }
        }
      )
    end
  end

  def bugs
    fetch.inject([]) do |sum, response|
      sum += (response["groups"] || [])
      sum
    end
  end

end
