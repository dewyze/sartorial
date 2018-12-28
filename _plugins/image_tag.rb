module Jekyll
  class ImageTag < Liquid::Tag
    def initialize(tag_name, source, tokens)
      super
      @source = source.strip
    end

    def render(context)
      parts = @source.split(", ")
      file = parts[0]
      options = {}
      if !parts[1].nil?
        parts[1..-1].inject(options) do |acc, part|
          k,v = part.split(": ")
          acc[k] = v
          acc
        end
      end

      base_url = context["site"]["baseurl"]

      result = "<img"
      result += " src=\"#{base_url}/assets/img/#{file}\""
      result += " class=\"#{options["class"]}\"" if options["class"]
      result += " alt=\"#{options["alt"]}\"" if options["alt"]
      result += "/>\n"
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageTag)
