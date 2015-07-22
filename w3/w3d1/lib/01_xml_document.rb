class XmlDocument
  def initialize(please_indent = false)
    @new_line = please_indent ? "\n" : ""
    @indentation = please_indent ? "  " : ""
  end

  def method_missing(method_name, attributes = {})
    result = "<#{method_name}"

    result << attributes.inject("") do |acc, (attr_name, attr_value)|
      "#{acc} #{attr_name.to_s}=\"#{attr_value}\""
    end

    if block_given?
      result << ">#{@new_line}#{indent(yield)}</#{method_name}"
    else
      result << "/"
    end

    result << ">#{@new_line}"

    result
  end

  def indent(string)
    lines = string.split("\n")
    indented_lines = lines.map { |line| "#{@indentation}#{line}"}
    "#{indented_lines.join("\n")}#{@new_line}"
  end
end
