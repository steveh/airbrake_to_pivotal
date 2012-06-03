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
        description =  {
          'File' => bug.values_at("file", "line_number").compact.join(':'),
          'Action' => bug.values_at("controller", "action").compact.join('#'),
          'Environment' => bug["rails_env"],
          'Exception' => bug["error_class"]
        }.map do |label, value|
          "#{label}: #{value}" if value && !value.empty?
        end.compact

        description << "\n#{bug["error_message"]}"

        xml.external_story do
          xml.external_id bug["id"]
          xml.name bug["error_message"]
          xml.description description.join("\n")
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