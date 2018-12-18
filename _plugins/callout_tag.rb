module Jekyll
  class CalloutTag < Liquid::Tag
    def initialize(tag_name, source, tokens)
      super
      @source = source
    end

    def render(context)
      @data = context[@source]
      "<div class=\"callout callout-#{@data["kind"]}\">#{@data["content"]}</div>"
    end
  end
end

Liquid::Template.register_tag('callout', Jekyll::CalloutTag)
