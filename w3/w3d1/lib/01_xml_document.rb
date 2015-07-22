class XmlDocument
  def initialize(indent = false)
    @new_line = indent ? "\n" : ""
    @indentation = indent ? "  " : ""
  end

  def method_missing(method_name, args = {})
    result = "<#{method_name}"

    result << args.inject("") do |acc, (arg_name, arg_value)|
      "#{acc} #{arg_name.to_s}=\"#{arg_value}\""
    end

    if block_given?
      nested_lines = yield.split("\n").map { |line| "#{@indentation}#{line}" }
      nested_string = nested_lines.join("\n")
      result << ">#{@new_line}#{nested_string}#{@new_line}</#{method_name}"
    else
      result << "/"
    end

    result << ">#{@new_line}"

    result
  end
end
