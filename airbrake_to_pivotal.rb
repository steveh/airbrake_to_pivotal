require "sinatra/base"
require "./airbrake"
require "./pivotal"

class AirbrakeToPivotal < Sinatra::Base

  $airbrake = Airbrake.new(ENV["AIRBRAKE_USERNAME"], ENV["AIRBRAKE_AUTH_TOKEN"], ENV["AIRBRAKE_PROJECT_ID"])

  $pivotal = Pivotal.new(ENV["AIRBRAKE_REQUESTOR"])

  use Rack::Auth::Basic do |username, password|
    username == ENV["HTTP_BASIC_USERNAME"] && password == ENV["HTTP_BASIC_PASSWORD"]
  end

  get "/" do
    bugs = $airbrake.bugs

    content_type "text/xml", :charset => "utf-8"

    content_type "text/xml", :charset => "utf-8"

    $pivotal.bugs_to_xml(bugs)
  end

end
