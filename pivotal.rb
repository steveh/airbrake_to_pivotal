require "builder"

class Pivotal

  attr_reader :requestor

  def initialize(requestor)
    @requestor = requestor
  end

  def bugs_to_xml(bugs)
    buffer = ""

    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)

    xml.instruct!

    xml.external_stories(:type => "array") do
      bugs.each do |bug|
        description = <<-EOF
File: #{bug.values_at("file", "line_number").compact.join(':')}
Controller: #{bug["controller"]}
Action: #{bug["action"]}
Environment: #{bug["rails_env"]}

#{bug["error_message"]}
EOF

        xml.external_story do
          xml.external_id bug["id"]
          xml.name bug["error_class"]
          xml.description description
          xml.requested_by requestor
          xml.created_at({ :type => "datetime" }, bug["created_at"])
          xml.story_type "bug"
          xml.estimate nil
        end
      end
    end

    buffer
  end

end