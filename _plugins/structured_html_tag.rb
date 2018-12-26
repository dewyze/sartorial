module Jekyll
  class StructuredHtmlTag < Liquid::Tag
    def initialize(tag_name, source, tokens)
      super
      @source = source.strip
    end

    def render(context)
      if context["page"]["data"] && !@source.start_with?("site.data")
        data = context["page"]["data"].inject(context) {|acc, key| acc[key]}
        @data = data[@source]
      else
        @data = context[@source]
      end

      result = "<div class=\"structured-html\">\n"
      @data["items"].each {|item| result += _item(item)}
      result += "</div>"
      result
    end

    private

    def _item(item)
      description = " - #{item["description"]}\n" if item["description"]
      result = "<ul>\n"
      result += "<li>\n"
      result += "<code class=\"scss-var\">#{item["tag"]}</code>#{description}"
      item["children"].each{|child| result += _item(child)} if item["children"]
      result += "</li>\n"
      result += "</ul>\n"
    end
  end
end

Liquid::Template.register_tag('structured_html', Jekyll::StructuredHtmlTag)
