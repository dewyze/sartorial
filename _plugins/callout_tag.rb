module Jekyll
  class CalloutTag < Liquid::Tag
    def initialize(tag_name, source, tokens)
      super
      @source = source.strip
    end

    def render(context)
      if context["page"]["data"]
        data = context["page"]["data"].inject(context) {|acc, key| acc[key]}
        @data = data["callouts"][@source]
      else
        @data = context[@source]
      end
      "<div class=\"callout callout-#{@data["kind"]}\">#{@data["content"]}</div>"
    end
  end
end

Liquid::Template.register_tag('callout', Jekyll::CalloutTag)
