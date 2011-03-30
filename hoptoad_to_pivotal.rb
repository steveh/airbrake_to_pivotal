require "sinatra/base"
require "./hoptoad"
require "./pivotal"

class HoptoadToPivotal < Sinatra::Base

  $hoptoad = Hoptoad.new(ENV["HOPTOAD_USERNAME"], ENV["HOPTOAD_AUTH_TOKEN"], ENV["HOPTOAD_PROJECT_ID"])

  $pivotal = Pivotal.new(ENV["HOPTOAD_REQUESTOR"])

  get "/" do
    bugs = $hoptoad.bugs

    $pivotal.bugs_to_xml(bugs)
  end

end