class XmlDocument
  def initialize(indented = false)
    @indented = indented
  end

  def method_missing(method_name, attributes = {}, &block)
    attributes_string = attributes.inject("") do |acc,(key,value)|
      acc + " #{key}='#{value}'"
    end

    if block.nil?
      "<#{method_name}#{attributes_string}/>#{new_line}"
    else
      "<#{method_name}#{attributes_string}>#{new_line}#{indent(block.call)}</#{method_name}>#{new_line}"
    end
  end

  def new_line
    return "" if !@indented
    "\n"
  end

  def indent(str)
    return str if !@indented
    lines = str.split("\n")
    indented_lines = lines.map {|line| "  " + line}
    indented_lines.join("\n") + "\n"
  end
end
