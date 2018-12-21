module Jekyll
  class StructuredHtmlTag < Liquid::Tag
    def initialize(tag_name, source, tokens)
      super
      @source = source
    end

    def render(context)
      @data = context[@source]

      result = "<ul class=\"structured_html\">\n"
      @data["items"].each {|item| result += _item(item)}
      result += "</ul>"
      result
    end

    private

    def _item(item)
      result = "<ul>\n"
      result += "<li>\n"
      result += "<code class=\"scss-var\">#{item["tag"]}</code> - #{item["description"]}\n"
      item["children"].each{|child| result += _item(child)} if item["children"]
      result += "</li>\n"
      result += "</ul>\n"
    end
  end
end

Liquid::Template.register_tag('structured_html', Jekyll::StructuredHtmlTag)